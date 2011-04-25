
<%@ page import="protocolo1_1.SecUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'secUser.label', default: 'SecUser')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'secUser.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'secUser.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="password" title="${message(code: 'secUser.password.label', default: 'Password')}" />
                        
                            <g:sortableColumn property="accountExpired" title="${message(code: 'secUser.accountExpired.label', default: 'Account Expired')}" />
                        
                            <g:sortableColumn property="accountLocked" title="${message(code: 'secUser.accountLocked.label', default: 'Account Locked')}" />
                        
                            <g:sortableColumn property="enabled" title="${message(code: 'secUser.enabled.label', default: 'Enabled')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${secUserInstanceList}" status="i" var="secUserInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${secUserInstance.id}">${fieldValue(bean: secUserInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: secUserInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: secUserInstance, field: "password")}</td>
                        
                            <td><g:formatBoolean boolean="${secUserInstance.accountExpired}" /></td>
                        
                            <td><g:formatBoolean boolean="${secUserInstance.accountLocked}" /></td>
                        
                            <td><g:formatBoolean boolean="${secUserInstance.enabled}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${secUserInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
