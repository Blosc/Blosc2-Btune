Releasing a version
===================

Preliminaries
-------------

- Make sure that ``RELEASE_NOTES.md`` and ``ANNOUNCE.md`` are up to
  date with the latest news in the release.

- Check that *VERSION* symbols in blosc2_btune/__init__.py *and* src/btune.h
  *and* pyproject.toml contain the correct info.

- Commit the changes with::

    $ git commit -a -m "Getting ready for release X.Y.Z"
    $ git push


Testing
-------

Follow the steps in README-DEVELOPERS.md file for locally creating and
installing the wheel, then test it::

  $ cd examples
  $ BTUNE_TRACE=1 python btune_config.py
  $ BTUNE_TRACE=1 BTUNE_TRADEOFF=0.9 BTUNE_USE_INFERENCE=3 python btune_config.py
  $ BTUNE_TRACE=1 BTUNE_MODELS_DIR="" python btune_config.py  # deactivate inference
  $ BTUNE_TRACE=1 python lossy.py  lossy_example.tif  # 3d tradeoff

Tagging
-------

- Create a tag ``X.Y.Z`` from ``main``.  Use the next message::

    $ git tag -a vX.Y.Z -m "Tagging version X.Y.Z"

- Push the tag to the github repo::

    $ git push --tags

- Create a new release visiting https://github.com/Blosc/blosc2_btune/releases/new
  and add the release notes copying them from `RELEASE_NOTES.md` document.


Check documentation
-------------------

Check that the `README.md` and `README-DEVELOPERS.md` are consistent with this new release.


Announcing
----------

- Send an announcement to the blosc and comp.compression mailing lists.
  Use the ``ANNOUNCE.md`` file as skeleton (likely as the definitive version).

- Tweet/toot about it from the @Blosc2 account.


Post-release actions
--------------------

- Edit *VERSION* symbols in blosc2_btune/__init__.py *and* src/btune.h *and* pyproject.toml in main to increment the
  version to the next minor one (i.e. X.Y.Z --> X.Y.(Z+1).dev0).

- Create new headers for adding new features in ``RELEASE_NOTES.md``
  and add this place-holder instead:

  #XXX version-specific blurb XXX#

- Commit the changes::

  $ git commit -a -m"Post X.Y.Z release actions done"
  $ git push

That's all folks!


.. Local Variables:
.. mode: rst
.. coding: utf-8
.. fill-column: 70
.. End:
