int calculateScale(List<int> values) {
  final average = (values.reduce((a, b) => a + b) / values.length).round();
  return average.clamp(0, 4); 
}