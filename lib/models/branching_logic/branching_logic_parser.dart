class BranchingLogicParser {

  String? parseBranchingLogic(String branchingLogicString) {

    String modifiedInput = branchingLogicString.toLowerCase();
    modifiedInput = modifiedInput.replaceAll('\n', '');
    modifiedInput = modifiedInput.replaceAll(' or ', ' || ');
    modifiedInput = modifiedInput.replaceAll(' and ', ' && ');

    String pattern = r'([a-z,0-9,_])\((?<=\()(.*?)(?=\))\)';
    RegExp regex = RegExp(pattern);
    modifiedInput = modifiedInput.replaceAllMapped(regex, (match) => '${match.group(1)}___${match.group(2)}');

    modifiedInput = modifiedInput.replaceAll('[', '').replaceAll(']', '');
    modifiedInput = modifiedInput.replaceAll('=', '==');
    modifiedInput = modifiedInput.replaceAll('!=', '!');
    modifiedInput = modifiedInput.replaceAll('<=', '<');
    modifiedInput = modifiedInput.replaceAll('>=', '>');
    modifiedInput = modifiedInput.replaceAll('<>', '!=');

    if (modifiedInput.isEmpty) {
      return null;
    }

    return modifiedInput;
  }
}
