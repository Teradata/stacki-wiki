This describes some changes between Stacki 4.0 and Stacki 5.0 for those who are needing some translation.


### Command Line

When referencing machines in your cluster, in stacki 4.0 you could use the appliance name to get all the appliances of that type. It was a quick and dirty way to regex.

In Stacki 5.0 you have to prefix the "backend" with a "classifier".

Current classifiers

Example:

In 4.0
```
# stack set host boot backend action=install
```

Now in 5.0
```
# stack set host boot a:backend action=installs
```

Regexes and lists are still supported.

Similarly "rack0" now becomes "r:0" and "frontend" becomes "a:frontend."

## Base Language

The base language for the stack command line is now Python 3.6. This shouldn't affect the CentOS/RHEL Python base which is 2.7 (finally!), since they sit in different trees. "python" still resolves to /usr/bin/python.

If you want to use python3, you can invoke /opt/stack/bin/python3. There's a learning curve there.
