package com.nf.lc.formbean;

import java.util.List;

public class FormBean<T> {

    private List<T> objList;

    public List<T> getObjList() {
        return objList;
    }

    public void setObjList(List<T> objList) {
        this.objList = objList;
    }
}
