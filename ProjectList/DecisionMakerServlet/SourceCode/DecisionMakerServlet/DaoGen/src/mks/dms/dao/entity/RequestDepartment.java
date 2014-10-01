/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mks.dms.dao.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ThachLN
 */
@Entity
@Table(name = "request_department")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RequestDepartment.findAll", query = "SELECT r FROM RequestDepartment r"),
    @NamedQuery(name = "RequestDepartment.findById", query = "SELECT r FROM RequestDepartment r WHERE r.id = :id"),
    @NamedQuery(name = "RequestDepartment.findByRequestId", query = "SELECT r FROM RequestDepartment r WHERE r.requestId = :requestId"),
    @NamedQuery(name = "RequestDepartment.findByDepartmentId", query = "SELECT r FROM RequestDepartment r WHERE r.departmentId = :departmentId"),
    @NamedQuery(name = "RequestDepartment.findByCreated", query = "SELECT r FROM RequestDepartment r WHERE r.created = :created"),
    @NamedQuery(name = "RequestDepartment.findByCreatedbyUsername", query = "SELECT r FROM RequestDepartment r WHERE r.createdbyUsername = :createdbyUsername"),
    @NamedQuery(name = "RequestDepartment.findByLastmodified", query = "SELECT r FROM RequestDepartment r WHERE r.lastmodified = :lastmodified"),
    @NamedQuery(name = "RequestDepartment.findByLastmodifiedbyUsername", query = "SELECT r FROM RequestDepartment r WHERE r.lastmodifiedbyUsername = :lastmodifiedbyUsername")})
public class RequestDepartment implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "REQUEST_ID")
    private Integer requestId;
    @Column(name = "DEPARTMENT_ID")
    private Integer departmentId;
    @Basic(optional = false)
    @Column(name = "CREATED")
    @Temporal(TemporalType.TIMESTAMP)
    private Date created;
    @Column(name = "CREATEDBY_USERNAME")
    private String createdbyUsername;
    @Column(name = "LASTMODIFIED")
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastmodified;
    @Column(name = "LASTMODIFIEDBY_USERNAME")
    private String lastmodifiedbyUsername;

    public RequestDepartment() {
    }

    public RequestDepartment(Integer id) {
        this.id = id;
    }

    public RequestDepartment(Integer id, Date created) {
        this.id = id;
        this.created = created;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public String getCreatedbyUsername() {
        return createdbyUsername;
    }

    public void setCreatedbyUsername(String createdbyUsername) {
        this.createdbyUsername = createdbyUsername;
    }

    public Date getLastmodified() {
        return lastmodified;
    }

    public void setLastmodified(Date lastmodified) {
        this.lastmodified = lastmodified;
    }

    public String getLastmodifiedbyUsername() {
        return lastmodifiedbyUsername;
    }

    public void setLastmodifiedbyUsername(String lastmodifiedbyUsername) {
        this.lastmodifiedbyUsername = lastmodifiedbyUsername;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RequestDepartment)) {
            return false;
        }
        RequestDepartment other = (RequestDepartment) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "mks.dms.dao.entity.RequestDepartment[ id=" + id + " ]";
    }
    
}