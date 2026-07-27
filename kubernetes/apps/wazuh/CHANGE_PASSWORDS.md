
# Change Default Passwords

## Table of Contents

1. [Wazuh Users](#change-the-password-of-wazuh-users)
2. [Create new User](#create-new-user)
3. [Other](#other)

## Resources

- [Official Docs](https://documentation.wazuh.com/current/deployment-options/deploying-with-kubernetes/kubernetes-deployment.html#change-the-password-of-wazuh-users)

## Change the password of Wazuh users

> Logout from Wazuh Dashboard before performing any actions, to prevent session errors!
1. Start Bash shell in `wazuh-indexer-0`
    ```bash
    kubectl exec -it wazuh-indexer-0 -n wazuh -- /bin/bash
    ```

2. Export path to a variable
    ```bash
    export JAVA_HOME=/usr/share/wazuh-indexer/jdk
    ````

3. Hash desired password
    ```bash
    bash /usr/share/wazuh-indexer/plugins/opensearch-security/tools/hash.sh -p "MyStrongPassword"
    ```
    Copy the generated hashed value

4. Replace Hash \
    **File:** `secrets/internal-users-secret.yml`

    - `admin`
        ```yaml
        admin:
        hash: "REPLACE-HASH"
        reserved: true
        backend_roles:
            - "admin"
        description: "Demo admin user"
        ```

    - `kibanaserver`
        ```yaml
        kibanaserver:
        hash: "REPLACE-HASH"
        reserved: true
        description: "Demo kibanaserver user"
        ```

5. Update Kubernetes Secrets
    - **Admin credentials - File:** `secrets/indexer-cred-secret.yaml`
        ```yaml
        apiVersion: v1
        kind: Secret
        metadata:
            name: indexer-cred
        type: Opaque
        stringData:
            username: admin
            password: MyStrongPassword
        ```
    
    - **Kibana Server credentials - File:** `secrets/dashboard-cred-secret.yaml`
        ```yaml
        apiVersion: v1
        kind: Secret
        metadata:
            name: dashboard-cred
        type: Opaque
        stringData:
            username: kibanaserver
            password: MyStrongPassword
        ```

6. Apply Kustomization file
    ```bash
    kubectl apply -k .
    ```

7. Start Bash shell again in `wazuh-indexer-0`
    ```bash
    kubectl exec -it wazuh-indexer-0 -n wazuh -- /bin/bash
    ```

8. Set the following variables
    ```bash
    export INSTALLATION_DIR=/usr/share/wazuh-indexer
    CACERT=$INSTALLATION_DIR/certs/root-ca.pem
    KEY=$INSTALLATION_DIR/certs/admin-key.pem
    CERT=$INSTALLATION_DIR/certs/admin.pem
    export JAVA_HOME=/usr/share/wazuh-indexer/jdk
    ````

9. Run `securityadmin.sh` script to apply changes
    ```bash
    bash /usr/share/wazuh-indexer/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/wazuh-indexer/opensearch-security/ -nhnv -cacert  $CACERT -cert $CERT -key $KEY -p 9200 -icl -h $NODE_NAME
    ```

## Create new User

1. Start Bash shell in `wazuh-indexer-0`
    ```bash
    kubectl exec -it wazuh-indexer-0 -n wazuh -- /bin/bash
    ```

2. Export path to a variable
    ```bash
    export JAVA_HOME=/usr/share/wazuh-indexer/jdk
    ````

3. Hash desired password
    ```bash
    bash /usr/share/wazuh-indexer/plugins/opensearch-security/tools/hash.sh -p "MyStrongPassword"
    ```
    Copy the generated hashed value

4. Modify default user \
    **File:** `secrets/internal-users-secret.yml`
    
    ```yaml
    user:
      hash: "REPLACE-HASH"
      reserved: false
      backend_roles:
        - "admin"
      description: "Default admin user for dashboard"
    ```
    Add your custom user with the hashed password generated in step 3

5. Apply Kustomization file
    ```bash
    kubectl apply -k .
    ```

6. Start Bash shell again in `wazuh-indexer-0`
    ```bash
    kubectl exec -it wazuh-indexer-0 -n wazuh -- /bin/bash
    ```

7. Set the following variables
    ```bash
    export INSTALLATION_DIR=/usr/share/wazuh-indexer
    CACERT=$INSTALLATION_DIR/certs/root-ca.pem
    KEY=$INSTALLATION_DIR/certs/admin-key.pem
    CERT=$INSTALLATION_DIR/certs/admin.pem
    export JAVA_HOME=/usr/share/wazuh-indexer/jdk
    ````

8. Run `securityadmin.sh` script to apply changes
    ```bash
    bash /usr/share/wazuh-indexer/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/wazuh-indexer/opensearch-security/ -nhnv -cacert  $CACERT -cert $CERT -key $KEY -p 9200 -icl -h $NODE_NAME
    ```

## Other

### Wazuh API Users

**File:** `secrets/wazuh-api-cred-secret.yaml`

**Password requirements:**
- Between 8 and 64 characters
- At least one uppercase and one lowercase letter
- At least one number
- At least one symbol

### Wazuh Authentication Password

**File:** `secrets/wazuh-authd-pass-secret.yaml`

Password that will be used to authenticate agents with manager.

### Wazuh Cluster Key

**File:** `secrets/wazuh-cluster-key-secret.yaml`

- Requires 32 characters length

Generate
```bash
openssl rand -hex 16
```