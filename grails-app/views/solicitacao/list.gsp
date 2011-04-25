
<%@ page import="protocolo1_1.Solicitacao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'solicitacao.label', default: 'Solicitacao')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'solicitacao.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="data" title="${message(code: 'solicitacao.data.label', default: 'Data')}" />
                        
                            <g:sortableColumn property="descricao" title="${message(code: 'solicitacao.descricao.label', default: 'Descricao')}" />
                        
                            <th><g:message code="solicitacao.requerente.label" default="Requerente" /></th>
                        
                            <th><g:message code="solicitacao.tipo.label" default="Tipo" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${solicitacaoInstanceList}" status="i" var="solicitacaoInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${solicitacaoInstance.id}">${fieldValue(bean: solicitacaoInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${solicitacaoInstance.data}" /></td>
                        
                            <td>${fieldValue(bean: solicitacaoInstance, field: "descricao")}</td>
                        
                            <td>${fieldValue(bean: solicitacaoInstance, field: "requerente")}</td>
                        
                            <td>${fieldValue(bean: solicitacaoInstance, field: "tipo")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${solicitacaoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
