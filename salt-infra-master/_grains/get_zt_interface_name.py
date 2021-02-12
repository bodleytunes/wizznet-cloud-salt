# -*- coding: utf-8 -*-
#!/usr/bin/env python

from __future__ import absolute_import
import logging

log = logging.getLogger(__name__)

try:
    import netifaces
except ImportError as err:
    log.error("Unable to load 'netifaces' library. Please make sure it's installed")
    raise


def get_zt_interface_name():
    grains = {"zt_interface_name": None}
    interfaces = netifaces.interfaces()

    for iface in interfaces:
        if "zt" in iface:
            grains["zt_interface_name"] = iface
            return grains

    return grains


# get_zt_interface_name()
