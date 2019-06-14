defmodule WaitTimes.Repo do
  use Ecto.Repo,
    otp_app: :wait_times,
    adapter: Ecto.Adapters.Postgres
end
