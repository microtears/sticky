import 'package:args/args.dart';

import "../lib/sticky_cli.dart" as sticky_cli;

const COMMAND_GENERATE_ASSETS = "generate-assets";

main(List<String> arguments) {
  final argParser = getParser();
  final args = argParser.parse(arguments);
  if (_handleHelp(argParser, args)) return;
  _handleCommand(args);
}

void _handleCommand(ArgResults args) {
  print("command:${args.command.name}\n");
  switch (args.command.name) {
    case COMMAND_GENERATE_ASSETS:
      _generateAssets(args);
      break;
    default:
  }
}

void _generateAssets(ArgResults args) =>
    sticky_cli.main(args.command["server"]);

bool _handleHelp(ArgParser argParser, ArgResults args) {
  if (args["help"]) {
    print([
      "HELP",
      argParser.usage,
    ].join("\n"));
    return true;
  }
  return false;
}

ArgParser getParser() {
  return ArgParser()
    ..addCommand(
        COMMAND_GENERATE_ASSETS,
        ArgParser()
          ..addFlag("server", defaultsTo: false, abbr: "s", negatable: false))
    ..addFlag(
      "help",
      abbr: "h",
      negatable: false,
      help: "Displays this help information.",
    );
}
