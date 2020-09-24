##############################################################################
One Person's Vim |em_dash| Custom Map: Type <kj> or <jk> to Escape Insert Mode
##############################################################################

.. |em_dash| unicode:: 0x2014 .. em dash

About This Plugin
=================

This plugin makes it easy to escape from Insert mode to Normal mode
simply by typing ``kj`` or ``jk``.

Requirements
============

This plugin wires mappings to commands provided by another plugin,
``vim-easyescape``, which you'll want to install.

- See:

  https://github.com/zhou13/vim-easyescape

Installation
============

Installation is easy using the packages feature (see ``:help packages``).

To install the package so that it will automatically load on Vim startup,
use a ``start`` directory, e.g.,

.. code-block:: bash

    mkdir -p ~/.vim/pack/landonb/start
    cd ~/.vim/pack/landonb/start

If you want to test the package first, make it optional instead
(see ``:help pack-add``):

.. code-block:: bash

    mkdir -p ~/.vim/pack/landonb/opt
    cd ~/.vim/pack/landonb/opt

Clone the project to the desired path:

.. code-block:: bash

    git clone https://github.com/landonb/vim-ovm-easyescape-kj-jk.git

If you installed to the optional path (``opt``), tell Vim to load the package:

.. code-block:: vim

   :packadd! vim-ovm-easyescape-kj-jk

otherwise Vim will automatically load the plugin when installed to ``start``.

Just once, tell Vim to build the online help:

.. code-block:: vim

   :Helptags

Then whenever you want to reference the help from Vim, run:

.. code-block:: vim

   :help vim-ovm-easyescape-kj-jk

