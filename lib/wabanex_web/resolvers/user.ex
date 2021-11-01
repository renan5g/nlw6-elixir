defmodule WabanexWeb.Resolvers.User do
  alias Wabanex.User.Get
  alias Wabanex.User.Create

  def get(%{id: user_id}, _ctx), do: Get.call(user_id)

  def create(%{input: params}, _ctx), do: Create.call(params)
end
