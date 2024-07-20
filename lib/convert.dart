import 'dart:convert';

class Choice {
  final String id;
  final String text;
  final List<Choice> choices;

  Choice(this.id, this.text, this.choices);
}

Choice parseJsonToTree(String jsonStr) {
  final parsed = json.decode(jsonStr);
  return _buildTree(parsed);
}

Choice _buildTree(Map<String, dynamic> json) {
  return Choice(
    json['id'],
    json['text'],
    (json['choices'] as List<dynamic>)
        .map((choiceJson) => _buildTree(choiceJson))
        .toList(),
  );
}

void main() {
  // Replace this with your actual JSON content or file reading logic
  final jsonString = '''
    {
      "id": "start",
      "text": "You find yourself in a dark forest. What do you do?",
      "choices": [
        {
          "id": "choice1",
          "text": "Follow the path to the left",
          "choices": [
            {
              "id": "choice1a",
              "text": "Investigate a glimmer in the distance",
              "choices": [],
            }
          ]
        },
        {
          "id": "choice2",
          "text": "Go deeper into the forest",
          "choices": [],
        }
      ]
    }
  ''';

  final decisionTree = parseJsonToTree(jsonString);

  // Print the decision tree for verification
}
