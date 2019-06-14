defmodule WaitTimes.DataSource do
  @moduledoc """
  Documentation for WaitTimes.DataSource.
  """

  alias WaitTimes.WaitTime

  def fetch() do
    case HTTPoison.get("https://dmv.odot.state.or.us/cf/waittime/index.cfm") do
      {:ok, response} ->
        case response.status_code do
          200 -> {:ok, parse_html(response.body)}
          _ -> {:error, "GET returned status code #{response.status_code}"}
        end

      _ ->
        {:error, "Request failed."}
    end
  end

  defp parse_html(html) do
    html
    |> Floki.find("#wait_time_table tbody tr")
    |> Enum.map(&get_row_data/1)
  end

  defp get_row_data(row) do
    [region, link, wait_time] =
      row
      |> Floki.find("td")
      |> Enum.map(fn {_element, _attributes, [content | _children]} -> content end)

    {_element, [{_, location_url}], [location]} = link

    %WaitTime{
      :location => String.trim(location),
      :location_url => String.trim(location_url),
      :region => String.trim(region),
      :wait_time_minutes => wait_time_minutes(wait_time)
    }
  end

  defp wait_time_minutes(wait_time) do
    wait_time = wait_time |> String.trim() |> remove_extra_spaces()

    minutes =
      case Regex.run(~r/(\d+) minute/, wait_time, capture: :all_but_first) do
        nil ->
          0

        [minutes_string] ->
          minutes_string |> String.to_integer()
      end

    hours =
      case Regex.run(~r/(\d+) hour/, wait_time, capture: :all_but_first) do
        nil ->
          0

        [hours_string] ->
          hours_string |> String.to_integer()
      end

    minutes + hours * 60
  end

  defp remove_extra_spaces(str) do
    str |> String.replace(~r/\s+/, " ")
  end
end
