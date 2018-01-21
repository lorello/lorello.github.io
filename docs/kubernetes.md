# Kubernetes

 * local deploy: [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
 * cloud deploy: [kops](https://github.com/kubernetes/kops/blob/master/docs/install.md)
 * management cli: [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## MiniKube

    minikube start
    minikube stop

## Kops

 1. create domain and delegate to Route 53: `k.devops.it`
 2. create an S3 bucket to store the state of kops (eg: `kops-state-dev.devops.it`)
 3. ensure that your console has a running config for
   * `awscli`
   * `ssh` (a public/private keys setup)
   * `kops`
 4. `kops create cluster --name k.devops.it --state=s3://kops-state-dev.devops.it --zones=eu-central-1a --node-count=2 --node-size=t2.micro --master-size=t2.micro --dns-zone=k.devops.it`
 5. `export KOPS_STATE_STORE=s3://kops-state-dev.devops.it`
 6. `kops update cluster k.devops.it --yes`
 7. `kops get cluster`

When your exercise is done:

    kops delete cluster --name k.devops.it --state=s3://kops-state-dev.cloud4wi.com

Test the cluster

    kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.4 --port=8080
    kubectl expose deployment hello-minikube --type=NodePort
    kubectl get service

## Useful commands

    kubectl config view
    kubectl create -f pod-something.yml
    kubectl get pod
    kubectl describe pod
    kubectl expose pod <pod> --port=444 --name=something
    kubectl port-forward <pod> 8080
    kubectl attach <podname> -i
    kubectl exec <pod> -- <command>

    kubectl run -i --tty busybox --image=busybox --restart=Never -- sh

### Commands output

```
I0103 20:06:19.122358   37479 create_cluster.go:439] Inferred --cloud=aws from zone "eu-central-1a"
I0103 20:06:19.122639   37479 create_cluster.go:971] Using SSH public key: /Users/lorello/.ssh/id_rsa.pub
I0103 20:06:21.887562   37479 subnets.go:184] Assigned CIDR 172.20.32.0/19 to subnet eu-central-1a
Previewing changes that will be made:

I0103 20:06:32.117533   37479 executor.go:91] Tasks: 0 done / 73 total; 31 can run
I0103 20:06:33.963192   37479 executor.go:91] Tasks: 31 done / 73 total; 24 can run
I0103 20:06:35.633850   37479 executor.go:91] Tasks: 55 done / 73 total; 16 can run
I0103 20:06:36.449792   37479 executor.go:91] Tasks: 71 done / 73 total; 2 can run
I0103 20:06:36.606435   37479 executor.go:91] Tasks: 73 done / 73 total; 0 can run
Will create resources:
  AutoscalingGroup/master-eu-central-1a.masters.k.devops.it
    MinSize                 1
    MaxSize                 1
    Subnets                 [name:eu-central-1a.k.devops.it]
    Tags                    {k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup: master-eu-central-1a, k8s.io/role/master: 1, Name: master-eu-central-1a.masters.k.devops.it, KubernetesCluster: k.devops.it}
    LaunchConfiguration     name:master-eu-central-1a.masters.k.devops.it

  AutoscalingGroup/nodes.k.devops.it
    MinSize                 2
    MaxSize                 2
    Subnets                 [name:eu-central-1a.k.devops.it]
    Tags                    {k8s.io/role/node: 1, Name: nodes.k.devops.it, KubernetesCluster: k.devops.it, k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup: nodes}
    LaunchConfiguration     name:nodes.k.devops.it

  DHCPOptions/k.devops.it
    DomainName              eu-central-1.compute.internal
    DomainNameServers       AmazonProvidedDNS

  EBSVolume/a.etcd-events.k.devops.it
    AvailabilityZone        eu-central-1a
    VolumeType              gp2
    SizeGB                  20
    Encrypted               false
    Tags                    {k8s.io/role/master: 1, Name: a.etcd-events.k.devops.it, KubernetesCluster: k.devops.it, k8s.io/etcd/events: a/a}

  EBSVolume/a.etcd-main.k.devops.it
    AvailabilityZone        eu-central-1a
    VolumeType              gp2
    SizeGB                  20
    Encrypted               false
    Tags                    {Name: a.etcd-main.k.devops.it, KubernetesCluster: k.devops.it, k8s.io/etcd/main: a/a, k8s.io/role/master: 1}

  IAMInstanceProfile/masters.k.devops.it

  IAMInstanceProfile/nodes.k.devops.it

  IAMInstanceProfileRole/masters.k.devops.it
    InstanceProfile         name:masters.k.devops.it id:masters.k.devops.it
    Role                    name:masters.k.devops.it

  IAMInstanceProfileRole/nodes.k.devops.it
    InstanceProfile         name:nodes.k.devops.it id:nodes.k.devops.it
    Role                    name:nodes.k.devops.it

  IAMRole/masters.k.devops.it
    ExportWithID            masters

  IAMRole/nodes.k.devops.it
    ExportWithID            nodes

  IAMRolePolicy/masters.k.devops.it
    Role                    name:masters.k.devops.it

  IAMRolePolicy/nodes.k.devops.it
    Role                    name:nodes.k.devops.it

  InternetGateway/k.devops.it
    VPC                     name:k.devops.it
    Shared                  false

  Keypair/apiserver-aggregator
    Subject                 cn=aggregator
    Type                    client
    Signer                  name:apiserver-aggregator-ca id:cn=apiserver-aggregator-ca

  Keypair/apiserver-aggregator-ca
    Subject                 cn=apiserver-aggregator-ca
    Type                    ca

  Keypair/apiserver-proxy-client
    Subject                 cn=apiserver-proxy-client
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/ca
    Subject                 cn=kubernetes
    Type                    ca

  Keypair/kops
    Subject                 o=system:masters,cn=kops
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/kube-controller-manager
    Subject                 cn=system:kube-controller-manager
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/kube-proxy
    Subject                 cn=system:kube-proxy
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/kube-scheduler
    Subject                 cn=system:kube-scheduler
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/kubecfg
    Subject                 o=system:masters,cn=kubecfg
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/kubelet
    Subject                 o=system:nodes,cn=kubelet
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/kubelet-api
    Subject                 cn=kubelet-api
    Type                    client
    Signer                  name:ca id:cn=kubernetes

  Keypair/master
    Subject                 cn=kubernetes-master
    Type                    server
    AlternateNames          [100.64.0.1, 127.0.0.1, api.internal.k.devops.it, api.k.devops.it, kubernetes, kubernetes.default, kubernetes.default.svc, kubernetes.default.svc.cluster.local]
    Signer                  name:ca id:cn=kubernetes

  LaunchConfiguration/master-eu-central-1a.masters.k.devops.it
    ImageID                 kope.io/k8s-1.8-debian-jessie-amd64-hvm-ebs-2017-12-02
    InstanceType            t2.micro
    SSHKey                  name:kubernetes.k.devops.it-c8:89:94:5e:f2:69:0f:02:73:2a:a2:a0:a5:50:48:6d id:kubernetes.k.devops.it-c8:89:94:5e:f2:69:0f:02:73:2a:a2:a0:a5:50:48:6d
    SecurityGroups          [name:masters.k.devops.it]
    AssociatePublicIP       true
    IAMInstanceProfile      name:masters.k.devops.it id:masters.k.devops.it
    RootVolumeSize          64
    RootVolumeType          gp2
    SpotPrice

  LaunchConfiguration/nodes.k.devops.it
    ImageID                 kope.io/k8s-1.8-debian-jessie-amd64-hvm-ebs-2017-12-02
    InstanceType            t2.micro
    SSHKey                  name:kubernetes.k.devops.it-c8:89:94:5e:f2:69:0f:02:73:2a:a2:a0:a5:50:48:6d id:kubernetes.k.devops.it-c8:89:94:5e:f2:69:0f:02:73:2a:a2:a0:a5:50:48:6d
    SecurityGroups          [name:nodes.k.devops.it]
    AssociatePublicIP       true
    IAMInstanceProfile      name:nodes.k.devops.it id:nodes.k.devops.it
    RootVolumeSize          128
    RootVolumeType          gp2
    SpotPrice

  ManagedFile/k.devops.it-addons-bootstrap
    Location                addons/bootstrap-channel.yaml

  ManagedFile/k.devops.it-addons-core.addons.k8s.io
    Location                addons/core.addons.k8s.io/v1.4.0.yaml

  ManagedFile/k.devops.it-addons-dns-controller.addons.k8s.io-k8s-1.6
    Location                addons/dns-controller.addons.k8s.io/k8s-1.6.yaml

  ManagedFile/k.devops.it-addons-dns-controller.addons.k8s.io-pre-k8s-1.6
    Location                addons/dns-controller.addons.k8s.io/pre-k8s-1.6.yaml

  ManagedFile/k.devops.it-addons-kube-dns.addons.k8s.io-k8s-1.6
    Location                addons/kube-dns.addons.k8s.io/k8s-1.6.yaml

  ManagedFile/k.devops.it-addons-kube-dns.addons.k8s.io-pre-k8s-1.6
    Location                addons/kube-dns.addons.k8s.io/pre-k8s-1.6.yaml

  ManagedFile/k.devops.it-addons-limit-range.addons.k8s.io
    Location                addons/limit-range.addons.k8s.io/v1.5.0.yaml

  ManagedFile/k.devops.it-addons-rbac.addons.k8s.io-k8s-1.8
    Location                addons/rbac.addons.k8s.io/k8s-1.8.yaml

  ManagedFile/k.devops.it-addons-storage-aws.addons.k8s.io-v1.6.0
    Location                addons/storage-aws.addons.k8s.io/v1.6.0.yaml

  ManagedFile/k.devops.it-addons-storage-aws.addons.k8s.io-v1.7.0
    Location                addons/storage-aws.addons.k8s.io/v1.7.0.yaml

  Route/0.0.0.0/0
    RouteTable              name:k.devops.it
    CIDR                    0.0.0.0/0
    InternetGateway         name:k.devops.it

  RouteTable/k.devops.it
    VPC                     name:k.devops.it

  RouteTableAssociation/eu-central-1a.k.devops.it
    RouteTable              name:k.devops.it
    Subnet                  name:eu-central-1a.k.devops.it

  SSHKey/kubernetes.k.devops.it-c8:89:94:5e:f2:69:0f:02:73:2a:a2:a0:a5:50:48:6d
    KeyFingerprint          37:a8:b9:4a:da:45:1e:ea:00:2f:89:ea:e8:50:02:00

  Secret/admin

  Secret/kube

  Secret/kube-proxy

  Secret/kubelet

  Secret/system:controller_manager

  Secret/system:dns

  Secret/system:logging

  Secret/system:monitoring

  Secret/system:scheduler

  SecurityGroup/masters.k.devops.it
    Description             Security group for masters
    VPC                     name:k.devops.it
    RemoveExtraRules        [port=22, port=443, port=2380, port=2381, port=4001, port=4002, port=4789, port=179]

  SecurityGroup/nodes.k.devops.it
    Description             Security group for nodes
    VPC                     name:k.devops.it
    RemoveExtraRules        [port=22]

  SecurityGroupRule/all-master-to-master
    SecurityGroup           name:masters.k.devops.it
    SourceGroup             name:masters.k.devops.it

  SecurityGroupRule/all-master-to-node
    SecurityGroup           name:nodes.k.devops.it
    SourceGroup             name:masters.k.devops.it

  SecurityGroupRule/all-node-to-node
    SecurityGroup           name:nodes.k.devops.it
    SourceGroup             name:nodes.k.devops.it

  SecurityGroupRule/https-external-to-master-0.0.0.0/0
    SecurityGroup           name:masters.k.devops.it
    CIDR                    0.0.0.0/0
    Protocol                tcp
    FromPort                443
    ToPort                  443

  SecurityGroupRule/master-egress
    SecurityGroup           name:masters.k.devops.it
    CIDR                    0.0.0.0/0
    Egress                  true

  SecurityGroupRule/node-egress
    SecurityGroup           name:nodes.k.devops.it
    CIDR                    0.0.0.0/0
    Egress                  true

  SecurityGroupRule/node-to-master-tcp-1-2379
    SecurityGroup           name:masters.k.devops.it
    Protocol                tcp
    FromPort                1
    ToPort                  2379
    SourceGroup             name:nodes.k.devops.it

  SecurityGroupRule/node-to-master-tcp-2382-4000
    SecurityGroup           name:masters.k.devops.it
    Protocol                tcp
    FromPort                2382
    ToPort                  4000
    SourceGroup             name:nodes.k.devops.it

  SecurityGroupRule/node-to-master-tcp-4003-65535
    SecurityGroup           name:masters.k.devops.it
    Protocol                tcp
    FromPort                4003
    ToPort                  65535
    SourceGroup             name:nodes.k.devops.it

  SecurityGroupRule/node-to-master-udp-1-65535
    SecurityGroup           name:masters.k.devops.it
    Protocol                udp
    FromPort                1
    ToPort                  65535
    SourceGroup             name:nodes.k.devops.it

  SecurityGroupRule/ssh-external-to-master-0.0.0.0/0
    SecurityGroup           name:masters.k.devops.it
    CIDR                    0.0.0.0/0
    Protocol                tcp
    FromPort                22
    ToPort                  22

  SecurityGroupRule/ssh-external-to-node-0.0.0.0/0
    SecurityGroup           name:nodes.k.devops.it
    CIDR                    0.0.0.0/0
    Protocol                tcp
    FromPort                22
    ToPort                  22

  Subnet/eu-central-1a.k.devops.it
    VPC                     name:k.devops.it
    AvailabilityZone        eu-central-1a
    CIDR                    172.20.32.0/19
    Shared                  false
    Tags                    {Name: eu-central-1a.k.devops.it, KubernetesCluster: k.devops.it, kubernetes.io/cluster/k.devops.it: owned, kubernetes.io/role/elb: 1}

  VPC/k.devops.it
    CIDR                    172.20.0.0/16
    EnableDNSHostnames      true
    EnableDNSSupport        true
    Shared                  false
    Tags                    {Name: k.devops.it, KubernetesCluster: k.devops.it, kubernetes.io/cluster/k.devops.it: owned}

  VPCDHCPOptionsAssociation/k.devops.it
    VPC                     name:k.devops.it
    DHCPOptions             name:k.devops.it

Must specify --yes to apply changes

Cluster configuration has been created.

Suggestions:
 * list clusters with: kops get cluster
 * edit this cluster with: kops edit cluster k.devops.it
 * edit your node instance group: kops edit ig --name=k.devops.it nodes
 * edit your master instance group: kops edit ig --name=k.devops.it master-eu-central-1a

Finally configure your cluster with: kops update cluster k.devops.it --yes



$ kops update cluster k.devops.it --yes

I0103 20:26:33.972291   37712 executor.go:91] Tasks: 0 done / 73 total; 31 can run
I0103 20:26:38.551266   37712 vfs_castore.go:430] Issuing new certificate: "ca"
I0103 20:26:39.664412   37712 vfs_castore.go:430] Issuing new certificate: "apiserver-aggregator-ca"
I0103 20:26:42.471653   37712 executor.go:91] Tasks: 31 done / 73 total; 24 can run
I0103 20:26:44.232161   37712 vfs_castore.go:430] Issuing new certificate: "master"
I0103 20:26:44.912815   37712 vfs_castore.go:430] Issuing new certificate: "kops"
I0103 20:26:45.180290   37712 vfs_castore.go:430] Issuing new certificate: "apiserver-proxy-client"
I0103 20:26:45.937739   37712 vfs_castore.go:430] Issuing new certificate: "kube-controller-manager"
I0103 20:26:46.115086   37712 vfs_castore.go:430] Issuing new certificate: "kubelet"
I0103 20:26:46.120062   37712 vfs_castore.go:430] Issuing new certificate: "kubelet-api"
I0103 20:26:46.184562   37712 vfs_castore.go:430] Issuing new certificate: "kubecfg"
I0103 20:26:46.707359   37712 vfs_castore.go:430] Issuing new certificate: "apiserver-aggregator"
I0103 20:26:46.985966   37712 vfs_castore.go:430] Issuing new certificate: "kube-scheduler"
I0103 20:26:47.184163   37712 vfs_castore.go:430] Issuing new certificate: "kube-proxy"
I0103 20:26:51.430634   37712 executor.go:91] Tasks: 55 done / 73 total; 16 can run
I0103 20:26:56.134750   37712 executor.go:91] Tasks: 71 done / 73 total; 2 can run
I0103 20:26:57.007112   37712 executor.go:91] Tasks: 73 done / 73 total; 0 can run
I0103 20:26:57.007156   37712 dns.go:153] Pre-creating DNS records
I0103 20:26:59.096587   37712 update_cluster.go:248] Exporting kubecfg for cluster
kops has set your kubectl context to k.devops.it

Cluster is starting.  It should be ready in a few minutes.

Suggestions:
 * validate cluster: kops validate cluster
 * list nodes: kubectl get nodes --show-labels
 * ssh to the master: ssh -i ~/.ssh/id_rsa admin@api.k.devops.it
The admin user is specific to Debian. If not using Debian please use the appropriate user based on your OS.
 * read about installing addons: https://github.com/kubernetes/kops/blob/master/docs/addons.md

```
