![Intro](./docs/petclinic-ui.png)

This is the Spring PetClinic Sample Application

# Prerequisites

* Latest Tomcat
* Maven

# Clone Project

1. Clone Project as follows:

	```
	git clone git@github.com:advlab/erebus.git
	cd erebus
	```

# Deploy Locally

1. Clone Project

	```
	git clone git@github.com:advlab/castor.git
	cd castor
	```

1. Run Project locally   

    | #       | Description           | Command  |
    | :------------- |:-------------| :-----|
    | 1      | Build and copy war | `mvn -f ${current.project.path} clean install && cp ${current.project.path}/target/*.war $TOMCAT_HOME/webapps/ROOT.war` |
    | 2      | Run Tomcat      |   `$TOMCAT_HOME/bin/catalina.sh run` |
    | 3 | Stop Tomcat      |    `$TOMCAT_HOME/bin/catalina.sh stop` |
    | 4 | Tomcat Debug Mode      |    `$TOMCAT_HOME/bin/catalina.sh jpda run` |

1. Test Local URLs

    ```
    http://localhost:8080
    http://localhost:8080/actuator/prometheus
    ```

# Login to OKD

1. Login to OKD Console and get Token

1. Login to OKD unsing the CLI

	```
	oc login https://OKD-URL:OKD-PORT --token=YOUR-TOKEN
	```

# Deploy on OKD

1. Login to OKD

1. Clone Project

	```
	git clone git@github.com:advlab/castor.git
	cd castor
	```

1. Deploy on OKD

    ```
    oc new-app wildfly:13.0~https://github.com/advlab/castor.git -l "app=castor,monitor=true"
    oc expose svc/castor
    ```

# Undeploy from OKD

1. Delete all application objects

    ```
    oc delete all -l app=castor
    ```