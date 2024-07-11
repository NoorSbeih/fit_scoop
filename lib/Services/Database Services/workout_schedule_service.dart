// services/workout_schedule_service.dart

// Define workout plans
Map<String, Map<String, Map<String, List<String>>>> workoutPlans = {
  'Male': {
    'A': {
      'Bodybuilding': [
        'vJiVnMfJHv78rPIFvRVT', 'yqbE008Hyahj95Nta3If', 'vmiw3Q7t7Qez6njpHOUi', 'Ory5Q8NA9NyORsU9nDyT', 'AASYeGlyl7sVP9uPryHh', 'No workout', 'mhLzp0Ja7i6zQ5IpbIb0'
      ],
      'Strength Training': [
        'YFcsG8x0gzXmbmGOWb6q', 'wVeBCrwg0UM3S36sEKo9', '0a9CyzWMF1BTUxnAuv6Q', 'ZYAuWWZX6ZnYGfSGNuBj', 'KSby5H1oZLMEQychgGXH', 'No workout', 'AxAO30bT6xAcWrKCV6Mm'
      ],
      'Powerlifting': [
        'GCZIirjz7XRupQVmId0B', 'No workout', 'ODxJ3CPW9Ll1BgDaBMtD', 'navQqEcgl3r46kMBjXtI', 'oYoBOIhGcnd3n1A1O85h', 'No workout', 'vWZdmBAoOf86zHCmlNxE'
      ],
    },
    'B': {
      'Bodybuilding': [
        'pmtdC4pQCvHxUFuVjQMp', 'VtUvZgLWT9K6xBd7qO8K', 'CX1sLdk3sBDCErAdWMx7', 'cAjWiacWTTVFGEjT6Rsj', 'tUvydaIO9SifC21x9TeI', 'No workout', 'xhlIjSH0k1vuvIOuZiGX'
      ],
      'Strength Training': [
        'lykZ4pto9mKwmNZjq1S0', 'No workout', 'No workout', '0dMLGlGrKFmWA1Z0Kj7d', 'nUsnL1YCUZ4Uv4832ZMb', 'No workout', 'j3rPbYE4gulhcfw5yq5k'
      ],
      'Powerlifting': [
        'GCZIirjz7XRupQVmId0B', 'No workout', 'ODxJ3CPW9Ll1BgDaBMtD', 'navQqEcgl3r46kMBjXtI', 'oYoBOIhGcnd3n1A1O85h', 'No workout', 'vWZdmBAoOf86zHCmlNxE'
      ],
    },
    'C':{
      'Bodybuilding': [
        'TYaJUSIBuVzIoEnmfJ7f', '9T3LNyzb0UzlVr4kEewV', 'No workout', 'Fl0mGx8wlJGBfU8ovI9B', 'S11xIrPVu6p7bgx8ShQI', 'No workout', 'TYaJUSIBuVzIoEnmfJ7f'
      ],
      'Strength Training': [
        'g9u6G6SNs6nH40dzuuIe', 'No workout', 'No workout', 'ALDtTv7bn04uRnSaFclc', '41csY5MPSx1rdXz2Opi2', 'No workout', 'Nm8E4pcyPbjuDESVN8Ko'
      ],
    },
    'D':{
      'Bodybuilding': [
        'workoutId43', 'eP4QxK0zplvt7rANJbPB', 'workoutId45', 'tGrHp8x7K6HU8sQtsyxe', 'MMjmHw7yDeyqMxrULboQ', 'workoutId48', 'lNEAy2Gx9vc5YLkIrlUO'
      ],
    }
  },
  'Female': {
    'A': {
      'Toning/Shaping': [
        'hnfAlDnIB9Ru34mbASsR', 'QYe16zY3AtFelnujecMp', 'No workout', 'e8YHCCMrcRPpAmrR4IQm', 'BbHax2GqI6apjFjR6Db2', 'No workout', 'YseWQxMpDtTt66k4JRYK'
      ],
      'Muscle Gain': [
        'QPS6K2kpMOarTE3ISIQb', 'JnRjU9afPtjaNF9opNab', 'kBSRAKYop14v6AOylUvr', 'CwLIAtpLK6kZaZjG2LfQ', 'ce6k40tvOYA2RiQ3hrW8', 'No workout', '6J6yDFRBitqOhP5i4LXx'
      ],
      'Strength Training': [
        'No workout', 'DYZySYaNrF13HIh4vVV0', 'qHXp5nFrXoa79n9yveGG', 'No workout', 'DvFpaAVFVhynaX1DsbyN', 'lbdlcviv698xIb1GSRGV', '0beHw4m8pgPJHWXOGsJC'
      ],

    },
    'B': {
      'Toning/Shaping': [
        '3GnI38Vy96MjGFYLhtWQ', 'QLKqgunqMi2T5Fh54Mv7', 'No workout', 'ZsLmN5d10a7WIROL4zZ3', 'BLpNH571kWv25Jat3ALd', 'No workout', '3omgckZfkjYZX8lAKacU'
      ],
      'Muscle Gain': [
        'xQDEtCYtee9ksbURNciB', 'ClKzp5ExPbyVTixgCHqq', 'atrIpEYrAba6tKrIZ1bJ', '9hcUNuamrtWHZFxUcOl1', 'Y6mzrPlaqYhLhFzRUm2v', 'No workout', '0N3itqGMcxcCwTRMU2Az'
      ],
      'Strength Training': [
        'No workout', 'FP1OJG5TmzSl7ITmVlZb', 'lS9ZVcTRSwsqZ69D0ko3', 'No workout', 'JrEkbUllILksTR7e9qZg', 'opaWX2UgJeMZEwZEqQ5o', 'xyoNBE0eHrWjh88Z6kg8'
      ],

    },
    'C': {
      'Toning/Shaping': [
        '3GnI38Vy96MjGFYLhtWQ', 'QLKqgunqMi2T5Fh54Mv7', 'No workout', 'ZsLmN5d10a7WIROL4zZ3', 'BLpNH571kWv25Jat3ALd', 'No workout', '3omgckZfkjYZX8lAKacU'
      ],
      'Muscle Gain': [
        'D3a2G8g1tnqdJyRkQoEo', 'workoutId65', 'workoutId66', 'K5LV7WyYYEhbiehcNLJ9', 'D3a2G8g1tnqdJyRkQoEo', 'workoutId69', 'K5LV7WyYYEhbiehcNLJ9'
      ],
      'Strength Training': [
        'No workout', 'pENFRMuvJxXLZCarkeI5', 'qlKV93UjYxHUPvr9MMfv', 'No workout', 'G8YKvehoWcQYllQdNii6', 'IxdPowOG7Fx95iBghAUX', 'HoKbmmUklIn8LpNQxBbB'
      ],

    },
    'D': {
      'Toning/Shaping': [
        'vNCKEqPxgiCbm0QtZS1u', 'RyPiTp2XOl03uLAVFnaO', 'No workout', 'bvN02veTdM5hOj2XJcPR', '6itY9NTiRGnLD3QnIhKc', 'workoutId76', 'FvkhvRJKyluQLwiq4zDT'
      ],

    }

  }
};

// Function to generate workout schedule
List<String> generateWorkoutSchedule(String gender, String bodyLevel, String fitnessGoal) {
  return workoutPlans[gender]?[bodyLevel]?[fitnessGoal] ?? [];
}