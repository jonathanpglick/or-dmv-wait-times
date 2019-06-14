defmodule WaitTimes do
  @moduledoc """
  Documentation for WaitTimes.
  """
  alias WaitTimes.DataSource
  alias WaitTimes.WaitTime

  def load_and_save_data() do
    case DataSource.fetch() do
      {:ok, wait_times} ->
        WaitTime.insert_all(wait_times)
        {:ok, wait_times}

      _ ->
        nil
    end
  end
end
