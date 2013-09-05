MachII-REST-Demo
================

A demo using the ColdFusion framework MachII with REST/Endpoints



SETUP INSTRUCTIONS
================


Configuration Folder
----------------------------------------------------------------------------------------------------
	Duplicate the ./server-config/RussellBrown folder to make it your own.
	All environment specific variables will be stored in these files!
	
	Any {filename}.properties file will get loaded in alphabetical order

IIS / Apache Mappings
----------------------------------------------------------------------------------------------------
	/Manager				:		{worspace-path}/main
	/Manager-Tests			:		{worspace-path}/tests


CF MAPPINGS
----------------------------------------------------------------------------------------------------
	1) /coldspring			:		ColdSpring 1.2
	2) /machII				:		MachII 1.9.0 BER
	3) /Manager-Config		:		{worspace-path}/server-config/{your-name|server}



CF DSN
----------------------------------------------------------------------------------------------------
	Must have a DB mappings using the DSN value from dsnMain in your custom properties file


MySQL
----------------------------------------------------------------------------------------------------
DB Backups are available in /mysql


MXUNIT
----------------------------------------------------------------------------------------------------
	You should have MXUNIT available on your webpath if you expect to run unit tests
	
	You will need to add several global variables to your ANT preferences in Eclipse.
		1) edgelearn.server.name
		2) edgelearn.server.port
		3) mxunit.systempath
		
		Their required values should be obvious