// services/workout_schedule_service.dart

// Define workout plans
// Define workout plans
Map<String, Map<String, Map<String, List<String>>>> workoutPlans = {
  'Male': {
    'A': {
      'Bodybuilding': [
        'OnMoUTHJ8w5WX5QaCLAN', 'JJ1rYJ2UGzWEN6NiugFr', 'LJXI8gyOSYLvFLq7xsE9', 'IkgJJqRidbHc6MYsbu2R', 'QYHPcICxY7y0ywnTJBJD', 'gSLvawFmV2Oj0T8Ef2ga', 'No workout'
      ],
      'muscle_gain': [
        'workoutId8', 'workoutId9', 'workoutId10', 'workoutId11', 'workoutId12', 'workoutId13', 'workoutId14'
      ],
      // Add more goals and corresponding workout IDs
    },
    'B': {
      'weight_loss': [
        'workoutId15', 'workoutId16', 'workoutId17', 'workoutId18', 'workoutId19', 'workoutId20', 'workoutId21'
      ],
      'muscle_gain': [
        'workoutId22', 'workoutId23', 'workoutId24', 'workoutId25', 'workoutId26', 'workoutId27', 'workoutId28'
      ],
      // Add more goals and corresponding workout IDs
    },
    'C':{
      'Bodybuilding': [
        'OnMoUTHJ8w5WX5QaCLAN', 'JJ1rYJ2UGzWEN6NiugFr', 'LJXI8gyOSYLvFLq7xsE9', 'IkgJJqRidbHc6MYsbu2R', 'QYHPcICxY7y0ywnTJBJD', 'gSLvawFmV2Oj0T8Ef2ga', 'No workout'
      ],
      'muscle_gain': [
        'workoutId36', 'workoutId37', 'workoutId38', 'workoutId39', 'workoutId40', 'workoutId41', 'workoutId42'
      ],
    },
    'D':{
      'weight_loss': [
        'workoutId43', 'workoutId44', 'workoutId45', 'workoutId46', 'workoutId47', 'workoutId48', 'workoutId49'
      ],
      'muscle_gain': [
        'workoutId50', 'workoutId51', 'workoutId52', 'workoutId53', 'workoutId54', 'workoutId55', 'workoutId56'
      ],
    }
    // Define plans for other body levels (C, D, E) similarly
  },
  'female': {
    'A': {
      'weight_loss': [
        'workoutId29', 'workoutId30', 'workoutId31', 'workoutId32', 'workoutId33', 'workoutId34', 'workoutId35'
      ],
      'muscle_gain': [
        'workoutId36', 'workoutId37', 'workoutId38', 'workoutId39', 'workoutId40', 'workoutId41', 'workoutId42'
      ],
      // Add more goals and corresponding workout IDs
    },
    'B': {
      'weight_loss': [
        'workoutId43', 'workoutId44', 'workoutId45', 'workoutId46', 'workoutId47', 'workoutId48', 'workoutId49'
      ],
      'muscle_gain': [
        'workoutId50', 'workoutId51', 'workoutId52', 'workoutId53', 'workoutId54', 'workoutId55', 'workoutId56'
      ],
      // Add more goals and corresponding workout IDs
    },
    // Define plans for other body levels (C, D, E) similarly
  }
};

// Function to generate workout schedule
List<String> generateWorkoutSchedule(String gender, String bodyLevel, String fitnessGoal) {
  return workoutPlans[gender]?[bodyLevel]?[fitnessGoal] ?? [];
}