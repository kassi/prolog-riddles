# Description

Collection of logic riddles solved with Prolog.

# Installation

    git clone git://github.com/kassi/prolog-riddles.git

# Contents

See Wiki.

# Run

I use to write the command line into a she-bang like line, even if the file is not executable.
You can run it with

    run=`head -1 $filename`; bash -c "${run##%\!}"

so creating a shell function like

    function prolog {
        local run=$(head -1 "$1")
        bash -c "${run##%\!}"
    }

might help with simply executing

    prolog filename.pro

# Author

Karsten Silkenbäumer

[![endorse](http://api.coderwall.com/ksi/endorsecount.png)](http://coderwall.com/ksi)
