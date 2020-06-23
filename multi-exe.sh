#!/bin/bash
# 批量执行脚本
ser=(etcd docker kube-apiserver kube-controller-manager kube-scheduler kubelet kube-proxy)
for i in ${ser[@]};do
 systemctl restart $i
 systemctl enable $i
 systemctl status $i
done
