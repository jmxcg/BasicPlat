package com.gmteam.framework.component.login.web;

import java.util.List;

public class TreeA  {
    private String id;
    private String title;
    private String parentId;
    private String root;
    private String treePathName;
    private List<TreeA> children;
    private boolean leaf;
    private boolean allowChildren;
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getParentId() {
        return parentId;
    }
    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    public String getRoot() {
        return root;
    }
    public void setRoot(String root) {
        this.root = root;
    }
    public String getTreePathName() {
        return treePathName;
    }
    public void setTreePathName(String treePathName) {
        this.treePathName = treePathName;
    }
    public boolean isLeaf() {
        return leaf;
    }
    public void setLeaf(boolean leaf) {
        this.leaf = leaf;
    }
    public boolean isAllowChildren() {
        return allowChildren;
    }
    public void setAllowChildren(boolean allowChildren) {
        this.allowChildren = allowChildren;
    }
    public List<TreeA> getChildren() {
        return children;
    }
    public void setChildren(List<TreeA> children) {
        this.children = children;
    }
    
}