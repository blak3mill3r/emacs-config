#!/usr/bin/env sh

# a workaround for a broken straight.el recipe for cider
# which mistakenly excludes cider-test.el because of the convention that *-test.el files are not needed by the implementation
# (use-package): clj-refactor/:catch: Cannot open load file: No such file or directory, cider-test
# clj-refactor.el apparently expects cider-test.el to be on the load-path
# but the straight.el recipe for it excludes it
# it still isn't clear to me after reading some of the mountain of straight.el documentation where the public recipe for cider actually lives
# hence this symlink I have to keep creating every time I reinstall cider using straight

cd straight/build/cider
ln -s ../../repos/cider/cider-test.el ./cider-test.el

