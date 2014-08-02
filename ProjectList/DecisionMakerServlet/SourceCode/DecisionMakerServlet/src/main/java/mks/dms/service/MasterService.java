/**
 * Licensed to Open-Ones under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Open-Ones licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package mks.dms.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import mks.dms.dao.controller.DepartmentJpaController;
import mks.dms.dao.controller.ExDepartmentJpaController;
import mks.dms.dao.controller.RequestTypeJpaController;
import mks.dms.dao.controller.exceptions.NonexistentEntityException;
import mks.dms.dao.entity.Department;
import mks.dms.dao.entity.RequestType;
import mks.dms.model.DepartmentModel;
import mks.dms.model.MasterNode;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import rocky.common.CHARA;

import com.google.gson.Gson;

/**
 * @author ThachLN
 *
 */
@Service
public class MasterService {
    /** Loger. */
    private final static Logger LOG = Logger.getLogger(MasterService.class);
    
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("DecisionMaker-DBModelPU");
    
    public List<Department> getDepartments() {
        DepartmentJpaController daoCtrl = new DepartmentJpaController(emf);
        
        List<Department> lstDepartments = daoCtrl.findDepartmentEntities();
        
        return lstDepartments;
    }

    public boolean createDepartment(DepartmentModel departmentModel) {
        boolean createOK = true;
        
        if (departmentModel == null) {
            createOK = false;
        } else {
            departmentModel.getData();
            DepartmentJpaController daoCtrl = new DepartmentJpaController(emf);
            Department department = new Department();

            daoCtrl.create(department);
            
        }
        
        return createOK;
    }
    
    /**
    * Get types of request.
    * <br/>
    * @return list of RequestType
    */
    public List<RequestType> getRequestTypes() {
        List<RequestType> lstRequestTypes;
        
        RequestTypeJpaController daoCtrl = new RequestTypeJpaController(emf);
        
        lstRequestTypes = daoCtrl.findRequestTypeEntities();
        
        return lstRequestTypes;
    }

    /**
    * [Give the description for method].
    * @param parentDepartment
    * @param data
    * @return
    */
    public boolean createDepartment(String parentCd, List<Object[]> data) {
        Iterator<Object[]> itRowData = data.iterator();
        
        ExDepartmentJpaController daoCtrl = new ExDepartmentJpaController(emf);

        List<Department> lstDepartment = new ArrayList<Department>();
        Department department;
        String cd;
        String name;
        String manager;
        String note;
        Object[] dataRow;

        while (itRowData.hasNext()) {
            dataRow = itRowData.next();
            
            if (isNotEmptyRow(dataRow)) {
                cd = (String) dataRow[0];
                name = (String) dataRow[1];
                manager = (String) dataRow[2];
                note = (String) dataRow[3];

                department = new Department();
                department.setCd(cd);
                department.setName(name);
                department.setDescription(note);
                department.setParentcd(parentCd);

                lstDepartment.add(department);
            }
        }
        
        //
        boolean createdOK = daoCtrl.recreateAll(lstDepartment);
        
        
        return createdOK;
    }
    
    /**
    * Check a data row is not empty.
    * @param dataRow items of columns in data row
    * @return true if there is an item is not null.
    */
    private boolean isNotEmptyRow(Object[] dataRow) {
        int len = (dataRow != null) ? dataRow.length : 0;
        
        for (int i = 0; i < len; i++) {
            if ((dataRow[i] != null) && !CHARA.BLANK.equals(dataRow[i])) {
                return true;
            }
        }
        
        return false;
    }

    public String getRootDepartmentJson() {
        List<MasterNode> beans = new ArrayList<MasterNode>();

        MasterNode rootDepartment = new MasterNode();
        rootDepartment.setId("root");
        rootDepartment.setType("#");
        rootDepartment.setChildren(beans);
        rootDepartment.setText("MyCompany");


        MasterNode subDepartment = new MasterNode();
        subDepartment.setId("node1.1");
        subDepartment.setType("file");
        subDepartment.setChildren(null);
        subDepartment.setText("Phòng Kế Toán");
        
        beans.add(subDepartment);
        
        // Node 1.2
        subDepartment = new MasterNode();
        subDepartment.setId("node1.2");
        subDepartment.setType("file");
        subDepartment.setChildren(null);
        subDepartment.setText("Kho");
        
        beans.add(subDepartment);
        // Add sub node
        //
        Gson gson = new Gson();
        String json = gson.toJson(rootDepartment);;

        return json;
    }

    public String getDepartmentJson(String parentDepartmentId) {
        List<MasterNode> beans = new ArrayList<MasterNode>();

        MasterNode department = new MasterNode();
        department.setId("sub-department");
        department.setType("file");
        department.setChildren(null);
        department.setText("Sub department");
        beans.add(department);

        Gson gson = new Gson();
        String json = gson.toJson(beans);;

        return json;
    }
    

}
