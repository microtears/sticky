Set-Location ./sticky_web
# Note: the --hot-reload option is not perfect. If you notice
# unexpected behavior, you may want to manually refresh the page.
# Note: the --hot-reload option is currently "stateless".
# Application state will be lost on reload. We do hope to offer
# "stateful" hot-reload on the web – we're actively working on it!
# Note: if you have trouble running the webdev serve --auto restart
# command, try running flutter pub global run webdev serve --auto
# restart instead.

# '-d' is disable auto restart.
[bool]
$enableHotload = !("-d" -eq $args[1])
if ($enableHotload) {
    $webArgs = "--auto restart"
}
else {
    $webArgs = ""
}

switch ($args[0]) {
    "debug" { webdev serve $webArgs }
    "release" { webdev serve -r $webArgs }
    "build" { webdev build }
    Default { webdev serve $webArgs }
}
Set-Location ..