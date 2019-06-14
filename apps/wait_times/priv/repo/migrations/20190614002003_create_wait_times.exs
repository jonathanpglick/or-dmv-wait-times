defmodule WaitTimes.Repo.Migrations.CreateWaitTimes do
  use Ecto.Migration

  def change do
    create table(:wait_times) do
      add(:location, :string)
      add(:region, :string)
      add(:wait_time_minutes, :integer)
      add(:location_url, :string)
      add(:datetime, :utc_datetime)
    end
  end
end
