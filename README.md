# README

Api Request - 

User can login and returns json.

User can find road trip data in json.

json weather forecast example:

'/api/v1/forecast?location=denver,co'

{
    "data": {
        "id": null,
        "type": "weather",
        "attributes": {
            "location_info": {
                "city": "Denver",
                "state": "Colorado",
                "country": "United States"
            },
            "current_time": "02:00 AM, June 10",
            "summary": "Clear Sky",
            "temp": 50,
            "temp_high": 78,
            "temp_low": 53,
            "feels_like": 46,
            "humidity": "43%",
            "visibility": " miles",
            "uv_index": 11.27,
            "sunrise": "05:31 AM",
            "sunset": "08:27 PM",
            "hourly_forecast": [
                {
                    "time": " 2 AM",
                    "temp": 50,
                    "summary": "clear sky"
                },
                {
                    "time": " 3 AM",
                    "temp": 52,
                    "summary": "clear sky"
                },
                {
                    "time": " 4 AM",
                    "temp": 54,
                    "summary": "clear sky"
                },
                {
                    "time": " 5 AM",
                    "temp": 54,
                    "summary": "clear sky"
                },
                {
                    "time": " 6 AM",
                    "temp": 54,
                    "summary": "clear sky"
                },
                {
                    "time": " 7 AM",
                    "temp": 56,
                    "summary": "clear sky"
                },
                {
                    "time": " 8 AM",
                    "temp": 60,
                    "summary": "clear sky"
                },
                {
                    "time": " 9 AM",
                    "temp": 63,
                    "summary": "clear sky"
                }
            ],
            "daily_forecast": [
                {
                    "day": "Wednesday",
                    "summary": "Clear",
                    "rain": "0 mm",
                    "temp_max": 78,
                    "temp_min": 53
                },
                {
                    "day": "Thursday",
                    "summary": "Clear",
                    "rain": "0 mm",
                    "temp_max": 83,
                    "temp_min": 62
                },
                {
                    "day": "Friday",
                    "summary": "Rain",
                    "rain": "0.3 mm",
                    "temp_max": 90,
                    "temp_min": 65
                },
                {
                    "day": "Saturday",
                    "summary": "Rain",
                    "rain": "3.47 mm",
                    "temp_max": 92,
                    "temp_min": 68
                },
                {
                    "day": "Sunday",
                    "summary": "Clouds",
                    "rain": "0 mm",
                    "temp_max": 91,
                    "temp_min": 66
                },
                {
                    "day": "Monday",
                    "summary": "Clouds",
                    "rain": "0 mm",
                    "temp_max": 92,
                    "temp_min": 69
                },
                {
                    "day": "Tuesday",
                    "summary": "Clouds",
                    "rain": "0 mm",
                    "temp_max": 94,
                    "temp_min": 68
                }
            ]
        }
    }
}
