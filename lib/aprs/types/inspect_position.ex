defimpl Inspect, for: AprsParse.Types.Position do
  alias AprsParse.Types.Position

  def inspect(d, %{:structs => false} = opts) do
    Inspect.Algebra.to_doc(d, opts)
  end

  def inspect(d, _opts) do
    "#{Position.to_string(d)}"
  end
end
