# == Schema Information
#
# Table name: weather_forecasts
#
#  id                  :bigint           not null, primary key
#  current             :json
#  current_date        :date
#  forecast            :json
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  weather_location_id :integer
#
# Indexes
#
#  index_location_and_date  (weather_location_id,current_date)
#
FactoryBot.define do
  factory :weather_forecast do
    weather_location

    current_date { '2024-12-18' }
    current do
      {
        last_updated_epoch: 1_734_558_300,
        last_updated:       '2024-12-18 22:45',
        temp_c:             12.7,
        temp_f:             54.9,
        is_day:             0,
        condition:          {
          text: 'Patchy rain nearby',
          icon: '//cdn.weatherapi.com/weather/64x64/night/176.png',
          code: 1063
        },
        wind_mph:           16.3,
        wind_kph:           26.3,
        wind_degree:        205,
        wind_dir:           'SSW',
        pressure_mb:        1012,
        pressure_in:        29.89,
        precip_mm:          0.01,
        precip_in:          0,
        humidity:           88,
        cloud:              100,
        feelslike_c:        10.4,
        feelslike_f:        50.7,
        windchill_c:        10.4,
        windchill_f:        50.7,
        heatindex_c:        12.8,
        heatindex_f:        55,
        dewpoint_c:         10.9,
        dewpoint_f:         51.5,
        vis_km:             10,
        vis_miles:          6,
        uv:                 0,
        gust_mph:           24.6,
        gust_kph:           39.6
      }
    end
    forecast do
      {
        forecastday: [
          {
            date:       '2024-12-18',
            date_epoch: 1_734_480_000,
            day:        {
              maxtemp_c:            12.5,
              maxtemp_f:            54.5,
              mintemp_c:            7.8,
              mintemp_f:            46,
              avgtemp_c:            10.5,
              avgtemp_f:            50.9,
              maxwind_mph:          17.9,
              maxwind_kph:          28.8,
              totalprecip_mm:       0.31,
              totalprecip_in:       0.01,
              totalsnow_cm:         0,
              avgvis_km:            10,
              avgvis_miles:         6,
              avghumidity:          76,
              daily_will_it_rain:   1,
              daily_chance_of_rain: 89,
              daily_will_it_snow:   0,
              daily_chance_of_snow: 0,
              condition:            {
                text: 'Patchy rain nearby',
                icon: '//cdn.weatherapi.com/weather/64x64/day/176.png',
                code: 1063
              },
              uv:                   0.1
            },
            astro:      {
              sunrise:           '08:40 AM',
              sunset:            '04:55 PM',
              moonrise:          '08:11 PM',
              moonset:           '11:33 AM',
              moon_phase:        'Waning Gibbous',
              moon_illumination: 92,
              is_moon_up:        1,
              is_sun_up:         0
            },
            hour:       [
              {
                time_epoch:     1_734_476_400,
                time:           '2024-12-18 00:00',
                temp_c:         7.8,
                temp_f:         46,
                is_day:         0,
                condition:      {
                  text: 'Partly Cloudy ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/116.png',
                  code: 1003
                },
                wind_mph:       8.7,
                wind_kph:       14,
                wind_degree:    197,
                wind_dir:       'SSW',
                pressure_mb:    1022,
                pressure_in:    30.19,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       69,
                cloud:          59,
                feelslike_c:    5.3,
                feelslike_f:    41.5,
                windchill_c:    5.3,
                windchill_f:    41.5,
                heatindex_c:    7.8,
                heatindex_f:    46,
                dewpoint_c:     2.6,
                dewpoint_f:     36.6,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       14.6,
                gust_kph:       23.5,
                uv:             0
              },
              {
                time_epoch:     1_734_480_000,
                time:           '2024-12-18 01:00',
                temp_c:         8.1,
                temp_f:         46.5,
                is_day:         0,
                condition:      {
                  text: 'Partly Cloudy ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/116.png',
                  code: 1003
                },
                wind_mph:       9.4,
                wind_kph:       15.1,
                wind_degree:    197,
                wind_dir:       'SSW',
                pressure_mb:    1022,
                pressure_in:    30.17,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       64,
                cloud:          47,
                feelslike_c:    5.5,
                feelslike_f:    41.9,
                windchill_c:    5.5,
                windchill_f:    41.9,
                heatindex_c:    8.1,
                heatindex_f:    46.5,
                dewpoint_c:     1.8,
                dewpoint_f:     35.2,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       16.3,
                gust_kph:       26.2,
                uv:             0
              },
              {
                time_epoch:     1_734_483_600,
                time:           '2024-12-18 02:00',
                temp_c:         7.9,
                temp_f:         46.2,
                is_day:         0,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/176.png',
                  code: 1063
                },
                wind_mph:       10.1,
                wind_kph:       16.2,
                wind_degree:    205,
                wind_dir:       'SSW',
                pressure_mb:    1021,
                pressure_in:    30.16,
                precip_mm:      0.01,
                precip_in:      0,
                snow_cm:        0,
                humidity:       62,
                cloud:          67,
                feelslike_c:    5.2,
                feelslike_f:    41.3,
                windchill_c:    5.2,
                windchill_f:    41.3,
                heatindex_c:    7.9,
                heatindex_f:    46.2,
                dewpoint_c:     1.1,
                dewpoint_f:     34,
                will_it_rain:   1,
                chance_of_rain: 86,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       17.9,
                gust_kph:       28.8,
                uv:             0
              },
              {
                time_epoch:     1_734_487_200,
                time:           '2024-12-18 03:00',
                temp_c:         8.3,
                temp_f:         47,
                is_day:         0,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/176.png',
                  code: 1063
                },
                wind_mph:       10.7,
                wind_kph:       17.3,
                wind_degree:    201,
                wind_dir:       'SSW',
                pressure_mb:    1021,
                pressure_in:    30.15,
                precip_mm:      0.05,
                precip_in:      0,
                snow_cm:        0,
                humidity:       62,
                cloud:          80,
                feelslike_c:    5.6,
                feelslike_f:    42,
                windchill_c:    5.6,
                windchill_f:    42,
                heatindex_c:    8.3,
                heatindex_f:    47,
                dewpoint_c:     1.5,
                dewpoint_f:     34.7,
                will_it_rain:   0,
                chance_of_rain: 64,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       18,
                gust_kph:       29,
                uv:             0
              },
              {
                time_epoch:     1_734_490_800,
                time:           '2024-12-18 04:00',
                temp_c:         8.5,
                temp_f:         47.3,
                is_day:         0,
                condition:      {
                  text: 'Partly Cloudy ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/116.png',
                  code: 1003
                },
                wind_mph:       10.5,
                wind_kph:       16.9,
                wind_degree:    197,
                wind_dir:       'SSW',
                pressure_mb:    1020,
                pressure_in:    30.12,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       62,
                cloud:          59,
                feelslike_c:    5.8,
                feelslike_f:    42.5,
                windchill_c:    5.8,
                windchill_f:    42.5,
                heatindex_c:    8.5,
                heatindex_f:    47.3,
                dewpoint_c:     1.6,
                dewpoint_f:     34.9,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       18.1,
                gust_kph:       29.2,
                uv:             0
              },
              {
                time_epoch:     1_734_494_400,
                time:           '2024-12-18 05:00',
                temp_c:         8.5,
                temp_f:         47.3,
                is_day:         0,
                condition:      {
                  text: 'Light rain shower',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/353.png',
                  code: 1240
                },
                wind_mph:       11.2,
                wind_kph:       18,
                wind_degree:    199,
                wind_dir:       'SSW',
                pressure_mb:    1020,
                pressure_in:    30.11,
                precip_mm:      0.19,
                precip_in:      0.01,
                snow_cm:        0,
                humidity:       62,
                cloud:          82,
                feelslike_c:    5.7,
                feelslike_f:    42.2,
                windchill_c:    5.7,
                windchill_f:    42.2,
                heatindex_c:    8.5,
                heatindex_f:    47.3,
                dewpoint_c:     1.6,
                dewpoint_f:     34.8,
                will_it_rain:   1,
                chance_of_rain: 100,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       19.2,
                gust_kph:       30.9,
                uv:             0
              },
              {
                time_epoch:     1_734_498_000,
                time:           '2024-12-18 06:00',
                temp_c:         9,
                temp_f:         48.3,
                is_day:         0,
                condition:      {
                  text: 'Partly Cloudy ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/116.png',
                  code: 1003
                },
                wind_mph:       12.3,
                wind_kph:       19.8,
                wind_degree:    202,
                wind_dir:       'SSW',
                pressure_mb:    1019,
                pressure_in:    30.1,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       58,
                cloud:          61,
                feelslike_c:    6.2,
                feelslike_f:    43.2,
                windchill_c:    6.2,
                windchill_f:    43.2,
                heatindex_c:    9.1,
                heatindex_f:    48.3,
                dewpoint_c:     1.3,
                dewpoint_f:     34.3,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       20.2,
                gust_kph:       32.5,
                uv:             0
              },
              {
                time_epoch:     1_734_501_600,
                time:           '2024-12-18 07:00',
                temp_c:         8.8,
                temp_f:         47.8,
                is_day:         0,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
                  code: 1009
                },
                wind_mph:       12.1,
                wind_kph:       19.4,
                wind_degree:    203,
                wind_dir:       'SSW',
                pressure_mb:    1019,
                pressure_in:    30.09,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       61,
                cloud:          100,
                feelslike_c:    5.9,
                feelslike_f:    42.6,
                windchill_c:    5.9,
                windchill_f:    42.6,
                heatindex_c:    8.8,
                heatindex_f:    47.8,
                dewpoint_c:     1.7,
                dewpoint_f:     35,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       20.1,
                gust_kph:       32.3,
                uv:             0
              },
              {
                time_epoch:     1_734_505_200,
                time:           '2024-12-18 08:00',
                temp_c:         9.2,
                temp_f:         48.6,
                is_day:         0,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
                  code: 1009
                },
                wind_mph:       12.1,
                wind_kph:       19.4,
                wind_degree:    207,
                wind_dir:       'SSW',
                pressure_mb:    1019,
                pressure_in:    30.09,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       66,
                cloud:          100,
                feelslike_c:    6.5,
                feelslike_f:    43.6,
                windchill_c:    6.5,
                windchill_f:    43.6,
                heatindex_c:    9.2,
                heatindex_f:    48.6,
                dewpoint_c:     3.3,
                dewpoint_f:     37.9,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       19.5,
                gust_kph:       31.4,
                uv:             0
              },
              {
                time_epoch:     1_734_508_800,
                time:           '2024-12-18 09:00',
                temp_c:         9.5,
                temp_f:         49.1,
                is_day:         1,
                condition:      {
                  text: 'Cloudy ',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/119.png',
                  code: 1006
                },
                wind_mph:       12.1,
                wind_kph:       19.4,
                wind_degree:    208,
                wind_dir:       'SSW',
                pressure_mb:    1019,
                pressure_in:    30.09,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       75,
                cloud:          75,
                feelslike_c:    6.8,
                feelslike_f:    44.2,
                windchill_c:    6.8,
                windchill_f:    44.2,
                heatindex_c:    9.5,
                heatindex_f:    49.1,
                dewpoint_c:     5.2,
                dewpoint_f:     41.4,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       19.4,
                gust_kph:       31.2,
                uv:             0
              },
              {
                time_epoch:     1_734_512_400,
                time:           '2024-12-18 10:00',
                temp_c:         9.9,
                temp_f:         49.8,
                is_day:         1,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/122.png',
                  code: 1009
                },
                wind_mph:       13.2,
                wind_kph:       21.2,
                wind_degree:    211,
                wind_dir:       'SSW',
                pressure_mb:    1019,
                pressure_in:    30.09,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       80,
                cloud:          97,
                feelslike_c:    7.1,
                feelslike_f:    44.8,
                windchill_c:    7.1,
                windchill_f:    44.8,
                heatindex_c:    9.9,
                heatindex_f:    49.8,
                dewpoint_c:     6.7,
                dewpoint_f:     44.1,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       20,
                gust_kph:       32.1,
                uv:             0.1
              },
              {
                time_epoch:     1_734_516_000,
                time:           '2024-12-18 11:00',
                temp_c:         10.7,
                temp_f:         51.3,
                is_day:         1,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/122.png',
                  code: 1009
                },
                wind_mph:       13.9,
                wind_kph:       22.3,
                wind_degree:    216,
                wind_dir:       'SW',
                pressure_mb:    1019,
                pressure_in:    30.09,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       83,
                cloud:          97,
                feelslike_c:    8.1,
                feelslike_f:    46.6,
                windchill_c:    8.1,
                windchill_f:    46.6,
                heatindex_c:    10.7,
                heatindex_f:    51.3,
                dewpoint_c:     7.9,
                dewpoint_f:     46.3,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       20.1,
                gust_kph:       32.3,
                uv:             0.1
              },
              {
                time_epoch:     1_734_519_600,
                time:           '2024-12-18 12:00',
                temp_c:         11.2,
                temp_f:         52.2,
                is_day:         1,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/176.png',
                  code: 1063
                },
                wind_mph:       13.4,
                wind_kph:       21.6,
                wind_degree:    220,
                wind_dir:       'SW',
                pressure_mb:    1019,
                pressure_in:    30.09,
                precip_mm:      0.01,
                precip_in:      0,
                snow_cm:        0,
                humidity:       83,
                cloud:          97,
                feelslike_c:    8.8,
                feelslike_f:    47.8,
                windchill_c:    8.8,
                windchill_f:    47.8,
                heatindex_c:    11.2,
                heatindex_f:    52.2,
                dewpoint_c:     8.5,
                dewpoint_f:     47.3,
                will_it_rain:   1,
                chance_of_rain: 80,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       19.8,
                gust_kph:       31.9,
                uv:             0.7
              },
              {
                time_epoch:     1_734_523_200,
                time:           '2024-12-18 13:00',
                temp_c:         11.7,
                temp_f:         53.1,
                is_day:         1,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/122.png',
                  code: 1009
                },
                wind_mph:       12.8,
                wind_kph:       20.5,
                wind_degree:    223,
                wind_dir:       'SW',
                pressure_mb:    1019,
                pressure_in:    30.08,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       82,
                cloud:          90,
                feelslike_c:    9.5,
                feelslike_f:    49.1,
                windchill_c:    9.5,
                windchill_f:    49.1,
                heatindex_c:    11.7,
                heatindex_f:    53.1,
                dewpoint_c:     8.9,
                dewpoint_f:     47.9,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       18.9,
                gust_kph:       30.5,
                uv:             0.4
              },
              {
                time_epoch:     1_734_526_800,
                time:           '2024-12-18 14:00',
                temp_c:         12.3,
                temp_f:         54.1,
                is_day:         1,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/176.png',
                  code: 1063
                },
                wind_mph:       12.8,
                wind_kph:       20.5,
                wind_degree:    223,
                wind_dir:       'SW',
                pressure_mb:    1018,
                pressure_in:    30.06,
                precip_mm:      0.01,
                precip_in:      0,
                snow_cm:        0,
                humidity:       81,
                cloud:          80,
                feelslike_c:    10.2,
                feelslike_f:    50.4,
                windchill_c:    10.2,
                windchill_f:    50.4,
                heatindex_c:    12.3,
                heatindex_f:    54.1,
                dewpoint_c:     9.2,
                dewpoint_f:     48.5,
                will_it_rain:   1,
                chance_of_rain: 77,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       19.2,
                gust_kph:       30.9,
                uv:             0.2
              },
              {
                time_epoch:     1_734_530_400,
                time:           '2024-12-18 15:00',
                temp_c:         12.4,
                temp_f:         54.4,
                is_day:         1,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/176.png',
                  code: 1063
                },
                wind_mph:       12.5,
                wind_kph:       20.2,
                wind_degree:    220,
                wind_dir:       'SW',
                pressure_mb:    1017,
                pressure_in:    30.04,
                precip_mm:      0.02,
                precip_in:      0,
                snow_cm:        0,
                humidity:       82,
                cloud:          66,
                feelslike_c:    10.4,
                feelslike_f:    50.8,
                windchill_c:    10.4,
                windchill_f:    50.8,
                heatindex_c:    12.4,
                heatindex_f:    54.4,
                dewpoint_c:     9.5,
                dewpoint_f:     49.2,
                will_it_rain:   0,
                chance_of_rain: 70,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       18.9,
                gust_kph:       30.4,
                uv:             0.1
              },
              {
                time_epoch:     1_734_534_000,
                time:           '2024-12-18 16:00',
                temp_c:         12.5,
                temp_f:         54.5,
                is_day:         1,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/day/176.png',
                  code: 1063
                },
                wind_mph:       11.6,
                wind_kph:       18.7,
                wind_degree:    215,
                wind_dir:       'SW',
                pressure_mb:    1017,
                pressure_in:    30.03,
                precip_mm:      0.01,
                precip_in:      0,
                snow_cm:        0,
                humidity:       83,
                cloud:          54,
                feelslike_c:    10.6,
                feelslike_f:    51.1,
                windchill_c:    10.6,
                windchill_f:    51.1,
                heatindex_c:    12.5,
                heatindex_f:    54.4,
                dewpoint_c:     9.7,
                dewpoint_f:     49.4,
                will_it_rain:   1,
                chance_of_rain: 89,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       17.7,
                gust_kph:       28.5,
                uv:             0.1
              },
              {
                time_epoch:     1_734_537_600,
                time:           '2024-12-18 17:00',
                temp_c:         12.1,
                temp_f:         53.9,
                is_day:         0,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/176.png',
                  code: 1063
                },
                wind_mph:       11.4,
                wind_kph:       18.4,
                wind_degree:    207,
                wind_dir:       'SSW',
                pressure_mb:    1016,
                pressure_in:    30.02,
                precip_mm:      0.01,
                precip_in:      0,
                snow_cm:        0,
                humidity:       85,
                cloud:          76,
                feelslike_c:    10.2,
                feelslike_f:    50.4,
                windchill_c:    10.2,
                windchill_f:    50.4,
                heatindex_c:    12.1,
                heatindex_f:    53.9,
                dewpoint_c:     9.8,
                dewpoint_f:     49.6,
                will_it_rain:   0,
                chance_of_rain: 68,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       17.5,
                gust_kph:       28.2,
                uv:             0
              },
              {
                time_epoch:     1_734_541_200,
                time:           '2024-12-18 18:00',
                temp_c:         11.8,
                temp_f:         53.2,
                is_day:         0,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
                  code: 1009
                },
                wind_mph:       11.4,
                wind_kph:       18.4,
                wind_degree:    200,
                wind_dir:       'SSW',
                pressure_mb:    1016,
                pressure_in:    30,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       88,
                cloud:          96,
                feelslike_c:    9.8,
                feelslike_f:    49.6,
                windchill_c:    9.8,
                windchill_f:    49.6,
                heatindex_c:    11.8,
                heatindex_f:    53.2,
                dewpoint_c:     9.9,
                dewpoint_f:     49.8,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       17.6,
                gust_kph:       28.3,
                uv:             0
              },
              {
                time_epoch:     1_734_544_800,
                time:           '2024-12-18 19:00',
                temp_c:         11.8,
                temp_f:         53.3,
                is_day:         0,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
                  code: 1009
                },
                wind_mph:       11.4,
                wind_kph:       18.4,
                wind_degree:    197,
                wind_dir:       'SSW',
                pressure_mb:    1015,
                pressure_in:    29.98,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       87,
                cloud:          100,
                feelslike_c:    9.8,
                feelslike_f:    49.7,
                windchill_c:    9.8,
                windchill_f:    49.7,
                heatindex_c:    11.8,
                heatindex_f:    53.3,
                dewpoint_c:     9.7,
                dewpoint_f:     49.4,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       17.8,
                gust_kph:       28.6,
                uv:             0
              },
              {
                time_epoch:     1_734_548_400,
                time:           '2024-12-18 20:00',
                temp_c:         11.9,
                temp_f:         53.5,
                is_day:         0,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
                  code: 1009
                },
                wind_mph:       13,
                wind_kph:       20.9,
                wind_degree:    198,
                wind_dir:       'SSW',
                pressure_mb:    1014,
                pressure_in:    29.95,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       89,
                cloud:          100,
                feelslike_c:    9.8,
                feelslike_f:    49.6,
                windchill_c:    9.8,
                windchill_f:    49.6,
                heatindex_c:    12,
                heatindex_f:    53.5,
                dewpoint_c:     10.1,
                dewpoint_f:     50.2,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       19.7,
                gust_kph:       31.7,
                uv:             0
              },
              {
                time_epoch:     1_734_552_000,
                time:           '2024-12-18 21:00',
                temp_c:         12.2,
                temp_f:         54,
                is_day:         0,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
                  code: 1009
                },
                wind_mph:       13.9,
                wind_kph:       22.3,
                wind_degree:    197,
                wind_dir:       'SSW',
                pressure_mb:    1013,
                pressure_in:    29.91,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       90,
                cloud:          100,
                feelslike_c:    10,
                feelslike_f:    50,
                windchill_c:    10,
                windchill_f:    50,
                heatindex_c:    12.2,
                heatindex_f:    54,
                dewpoint_c:     10.7,
                dewpoint_f:     51.3,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       21,
                gust_kph:       33.8,
                uv:             0
              },
              {
                time_epoch:     1_734_555_600,
                time:           '2024-12-18 22:00',
                temp_c:         12.7,
                temp_f:         54.9,
                is_day:         0,
                condition:      {
                  text: 'Patchy rain nearby',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/176.png',
                  code: 1063
                },
                wind_mph:       16.3,
                wind_kph:       26.3,
                wind_degree:    205,
                wind_dir:       'SSW',
                pressure_mb:    1012,
                pressure_in:    29.89,
                precip_mm:      0.01,
                precip_in:      0,
                snow_cm:        0,
                humidity:       88,
                cloud:          100,
                feelslike_c:    10.4,
                feelslike_f:    50.7,
                windchill_c:    10.4,
                windchill_f:    50.7,
                heatindex_c:    12.8,
                heatindex_f:    55,
                dewpoint_c:     10.9,
                dewpoint_f:     51.5,
                will_it_rain:   1,
                chance_of_rain: 79,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       24.6,
                gust_kph:       39.6,
                uv:             0
              },
              {
                time_epoch:     1_734_559_200,
                time:           '2024-12-18 23:00',
                temp_c:         13,
                temp_f:         55.5,
                is_day:         0,
                condition:      {
                  text: 'Overcast ',
                  icon: '//cdn.weatherapi.com/weather/64x64/night/122.png',
                  code: 1009
                },
                wind_mph:       17.9,
                wind_kph:       28.8,
                wind_degree:    212,
                wind_dir:       'SSW',
                pressure_mb:    1012,
                pressure_in:    29.87,
                precip_mm:      0,
                precip_in:      0,
                snow_cm:        0,
                humidity:       81,
                cloud:          100,
                feelslike_c:    10.6,
                feelslike_f:    51.1,
                windchill_c:    10.6,
                windchill_f:    51.1,
                heatindex_c:    13,
                heatindex_f:    55.5,
                dewpoint_c:     9.9,
                dewpoint_f:     49.8,
                will_it_rain:   0,
                chance_of_rain: 0,
                will_it_snow:   0,
                chance_of_snow: 0,
                vis_km:         10,
                vis_miles:      6,
                gust_mph:       27.4,
                gust_kph:       44.1,
                uv:             0
              }
            ]
          }
        ]
      }
    end
  end
end
