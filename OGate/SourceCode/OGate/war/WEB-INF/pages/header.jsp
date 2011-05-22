<%-- 
/*
 * header.jsp 0.1 Apr 30, 2011
 * 
 * Copyright (c) 2011, Open-Ones Group
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 --%>
<%--
Part: Header
Contains: 
 + Open-Ones's slogan (done)
 + List of sponsors (not)
 + Hot news (not)
 + Change language (done)
 + Logon/Logout (done)
 + Setting (for authorized user) (not)
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="com.google.appengine.api.users.UserService"%>
<%@page import="com.google.appengine.api.users.User"%>
<%@page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@page import="openones.gate.Cons"%>
<%@page import="openones.gate.control.LayoutControl"%>

<form name="frmHeader" action="header.do" method="post">
  <input type="hidden" name="screenId" value="Header" />
  <input type="hidden" name="eventId" value="" />
<table id="table2" width="100%" class="uportal-background-light" border="0" height="20">
    <tbody>
        <tr>
            <td width="49"><a href="www.open-ones.com"><img src="pages/images/oog_logo.png" border="0" width="150" height="50"></a></td>
            <td>
            <p align="center"><font size="6">${applicationScope.ShareAssociateDevelopIdea}</font></p>
            </td>
            <td width="148">
            <table id="table3" width="100%" border="0" cellpadding="0"
                cellspacing="0">
                <tbody>
                    <tr>
                      <td nowrap="nowrap" align="right">
                        ${applicationScope.Language}: <select size="1" name="lang" onchange='submitAction("frmHeader","Header", "changeLanguage")'>
                            <c:forEach var="langItem" items="${outForm.langList}">
                              <c:if test='${langItem.name == lang}'>
                                <option id="${langItem.id}" selected="selected">${langItem.name}</option>
                              </c:if>
                              <c:if test='${langItem.name != lang}'>
                                <option id="${langItem.id}">${langItem.name}</option>
                              </c:if>
                            </c:forEach>
                            
                        </select>
                        <%-- Display Setting link --%>
                        <c:if test="${(not empty user) && (user.isAdmin)}">
                         <a href="#" title="${applicationScope.SettingLinkTitle}" onclick='submitAction("frmHeader","Header", "setting")'><img src="pages/images/setting.gif" border="0" width="20" height="20"></a>
                        </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap">
                        <c:if test="${empty user}">
                          <input type="button" value="${applicationScope.Logon}" name="login" onclick='submitAction("frmHeader","Header", "login")'>
                        </c:if>
                        <c:if test="${not empty user}">
                          ${applicationScope.Welcome} ${user.nickname} !
                          <input type="button" value="${applicationScope.Logoff}" name="logout" onclick='submitAction("frmHeader","Header", "logout")'>
                        </c:if>
                        </td>
                    </tr>
                </tbody>
            </table>
            </td>
        </tr>
    </tbody>
</table>
</form>