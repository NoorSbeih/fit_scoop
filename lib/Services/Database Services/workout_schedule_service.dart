// services/workout_schedule_service.dart

// Define workout plans
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
        'YFcsG8x0gzXmbmGOWb6q', 'wVeBCrwg0UM3S36sEKo9', '0a9CyzWMF1BTUxnAuv6Q', 'ZYAuWWZX6ZnYGfSGNuBj', 'KSby5H1oZLMEQychgGXH', 'No workout', 'AxAO30bT6xAcWrKCV6Mm'
      ],
      // Add more goals and corresponding workout IDs
    },
    'B': {
      'Bodybuilding': [
        'pmtdC4pQCvHxUFuVjQMp', 'VtUvZgLWT9K6xBd7qO8K', 'CX1sLdk3sBDCErAdWMx7', 'cAjWiacWTTVFGEjT6Rsj', 'tUvydaIO9SifC21x9TeI', 'No workout', 'xhlIjSH0k1vuvIOuZiGX'
      ],
      'Strength Training': [
        'lykZ4pto9mKwmNZjq1S0', 'No workout', 'No workout', '0dMLGlGrKFmWA1Z0Kj7d', 'nUsnL1YCUZ4Uv4832ZMb', 'No workout', 'j3rPbYE4gulhcfw5yq5k'
      ],
      'Powerlifting': [
        'YFcsG8x0gzXmbmGOWb6q', 'wVeBCrwg0UM3S36sEKo9', '0a9CyzWMF1BTUxnAuv6Q', 'ZYAuWWZX6ZnYGfSGNuBj', 'KSby5H1oZLMEQychgGXH', 'No workout', 'AxAO30bT6xAcWrKCV6Mm'
      ],
      // Add more goals and corresponding workout IDs
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
      'Bodybuilding': [ // sunday, monday, tuesday, wednesday, thursday, friday, saturday
        'workoutId43', 'eP4QxK0zplvt7rANJbPB', 'workoutId45', 'tGrHp8x7K6HU8sQtsyxe', 'MMjmHw7yDeyqMxrULboQ', 'workoutId48', 'lNEAy2Gx9vc5YLkIrlUO'
      ],
    }
    // Define plans for other body levels (C, D, E) similarly
  },
  'Female': {
    'A': {
      'Toning/Shaping': [
        'workoutId29', 'workoutId30', 'workoutId31', 'workoutId32', 'workoutId33', 'workoutId34', 'workoutId35'
      ],
      'Muscle Gain': [
        'QPS6K2kpMOarTE3ISIQb', 'JnRjU9afPtjaNF9opNab', 'kBSRAKYop14v6AOylUvr', 'CwLIAtpLK6kZaZjG2LfQ', 'ce6k40tvOYA2RiQ3hrW8', 'No workout', '6J6yDFRBitqOhP5i4LXx'
      ],
      'Strength Training': [
        'workoutId43', 'workoutId44', 'workoutId45', 'workoutId46', 'workoutId47', 'workoutId48', 'workoutId49'
      ],
      // Add more goals and corresponding workout IDs
    },
    'B': {
      'Toning/Shaping': [
        'workoutId43', 'workoutId44', 'workoutId45', 'workoutId46', 'workoutId47', 'workoutId48', 'workoutId49'
      ],
      'Muscle Gain': [
        'workoutId50', 'workoutId51', 'workoutId52', 'workoutId53', 'workoutId54', 'workoutId55', 'workoutId56'
      ],
      'Strength Training': [
        'workoutId57', 'workoutId58', 'workoutId59', 'workoutId60', 'workoutId61', 'workoutId62', 'workoutId63'
      ],
      // Add more goals and corresponding workout IDs
    },
    'C': {
      'Toning/Shaping': [
        'workoutId57', 'workoutId58', 'workoutId59', 'workoutId60', 'workoutId61', 'workoutId62', 'workoutId63'
      ],
      'Muscle Gain': [
        'workoutId64', 'workoutId65', 'workoutId66', 'workoutId67', 'workoutId68', 'workoutId69', 'workoutId70'
      ],
      'Strength Training': [
        'workoutId71', 'workoutId72', 'workoutId73', 'workoutId74', 'workoutId75', 'workoutId76', 'workoutId77'
      ],
      // Add more goals and corresponding workout IDs
    },
    'D': {
      'Toning/Shaping': [
        'workoutId71', 'workoutId72', 'workoutId73', 'workoutId74', 'workoutId75', 'workoutId76', 'workoutId77'
      ],
      // Add more goals and corresponding workout IDs
    }
    // Define plans for other body levels (C, D, E) similarly
  }
};

// Function to generate workout schedule
List<String> generateWorkoutSchedule(String gender, String bodyLevel, String fitnessGoal) {
  return workoutPlans[gender]?[bodyLevel]?[fitnessGoal] ?? [];
}