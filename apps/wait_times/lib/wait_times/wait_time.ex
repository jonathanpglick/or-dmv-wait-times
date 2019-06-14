defmodule WaitTimes.WaitTime do
  use Ecto.Schema

  schema "wait_times" do
    field(:location, :string)
    field(:region, :string)
    field(:wait_time_minutes, :integer)
    field(:location_url, :string)
    field(:datetime, :utc_datetime)
  end

  def insert_all(wait_times) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    wait_times
    |> Enum.map(&Map.put(&1, :datetime, now))
    |> Enum.map(&WaitTimes.Repo.insert(&1))
  end
end
