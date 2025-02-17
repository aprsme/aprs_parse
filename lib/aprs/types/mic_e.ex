defmodule AprsParse.Types.MicE do
  @moduledoc """
  Type struct for MicE
  """
  defstruct lat_degrees: 0,
            lat_minutes: 0,
            lat_fractional: 0,
            lat_direction: :unknown,
            lon_direction: :unknown,
            longitude_offset: 0,
            message_code: nil,
            message_description: nil,
            dti: nil,
            heading: 0,
            lon_degrees: 0,
            lon_minutes: 0,
            lon_fractional: 0,
            speed: 0,
            manufacturer: :unknown,
            message: ""
end
