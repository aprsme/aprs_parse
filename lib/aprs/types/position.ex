defmodule AprsParse.Types.Position do
  @moduledoc """
  Positition Decoder
  """
  alias __MODULE__
  require Logger

  defstruct lat_degrees: 0,
            lat_minutes: 0,
            lat_fractional: 0,
            lat_direction: :unknown,
            lon_direction: :unknown,
            lon_degrees: 0,
            lon_minutes: 0,
            lon_fractional: 0

  def from_aprs(aprs_latitude, aprs_longitude) do
    aprs_latitude = aprs_latitude |> String.replace(" ", "0") |> String.pad_leading(9, "0")
    aprs_longitude = aprs_longitude |> String.replace(" ", "0") |> String.pad_leading(9, "0")

    # Logger.debug("#{aprs_latitude} #{aprs_longitude}")

    <<latitude::binary-size(8), lat_direction::binary>> = aprs_latitude
    <<longitude::binary-size(8), lon_direction::binary>> = aprs_longitude

    <<lat_deg::binary-size(3), lat_min::binary-size(2), lat_fractional::binary-size(3)>> =
      convert_garbage_to_zero(latitude)

    <<lon_deg::binary-size(3), lon_min::binary-size(2), lon_fractional::binary-size(3)>> =
      convert_garbage_to_zero(longitude)

    %Position{
      lat_degrees: lat_deg |> String.to_integer(),
      lat_minutes: lat_min |> String.to_integer(),
      lat_fractional: convert_fractional(lat_fractional),
      lat_direction: convert_direction(lat_direction),
      lon_degrees: lon_deg |> String.to_integer(),
      lon_minutes: lon_min |> String.to_integer(),
      lon_fractional: convert_fractional(lon_fractional),
      lon_direction: convert_direction(lon_direction)
    }
  end

  defp convert_garbage_to_zero(value) do
    try do
      _ = String.to_float(value)
      value
    rescue
      ArgumentError -> "00000.00"
    end
  end

  def to_string(%__MODULE__{} = position) do
    "#{position.lat_degrees}°" <>
      "#{position.lat_minutes}'" <>
      "#{position.lat_fractional}\"" <>
      "#{convert_direction(position.lat_direction)} " <>
      "#{position.lon_degrees}°" <>
      "#{position.lon_minutes}'" <>
      "#{position.lon_fractional}\"" <> "#{convert_direction(position.lon_direction)}"
  end

  defp convert_direction("N"), do: :north
  defp convert_direction("S"), do: :south
  defp convert_direction("E"), do: :east
  defp convert_direction("W"), do: :west
  defp convert_direction(:north), do: "N"
  defp convert_direction(:south), do: "S"
  defp convert_direction(:east), do: "E"
  defp convert_direction(:west), do: "W"
  defp convert_direction(:unknown), do: ""
  defp convert_direction(_nomatch), do: ""

  defp convert_fractional(fractional),
    do:
      fractional
      |> String.trim()
      |> String.pad_leading(4, "0")
      |> String.to_float()
      |> Kernel.*(60)
      |> Float.round(2)
end
