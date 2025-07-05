defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{
        battery_percentage: 100,
        distance_driven_in_meters: 0,
        nickname: nickname
      }
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    d = remote_car.distance_driven_in_meters
    "#{d} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) do
    b = remote_car.battery_percentage
    if b == 0 do
      "Battery empty"
    else
      "Battery at #{b}%"
    end
  end

  def drive(%RemoteControlCar{} = remote_car) do
    b = remote_car.battery_percentage
    d = remote_car.distance_driven_in_meters
    if b <= 0 do 
      remote_car
    else
      remote_car = %{remote_car | battery_percentage: b - 1}
      %{remote_car | distance_driven_in_meters: d + 20}
    end
  end
end
