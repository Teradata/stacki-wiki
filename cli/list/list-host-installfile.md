## list host installfile

### Usage

`stack list host installfile [section=string]`

### Description

Process an XML-based installation file and output an OS-specific
	installation file (e.g., a kickstart or jumpstart file).

### Parameters
* `[section=string]`

   Which section within the XML installation file to process (e.g.,
	"kickstart", "begin", etc.).

### Examples

* `stack list host installfile section="kickstart"`

   Output a RedHat-compliant kickstart file.



