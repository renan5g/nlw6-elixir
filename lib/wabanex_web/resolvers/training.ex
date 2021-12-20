defmodule WabanexWeb.Resolvers.Training do
  alias Wabanex.Trainings.Create

  def create(%{input: params}, _ctx), do: Create.call(params)
end
