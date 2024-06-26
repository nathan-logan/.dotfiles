return {
  s({
    trig = "dlog",
    name = "Insert debug console log",
    desc = "Inserts a console.log() with @@@ prefixed for debugging",
  }, {
    t("console.log(\"@@@"),
    i(1),
    t("\", "),
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t(");")
  }),
}
