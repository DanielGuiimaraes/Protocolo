

<%@ page import="protocolo1_1.Solicitacao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'solicitacao.label', default: 'Solicitacao')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${solicitacaoInstance}">
            <div class="errors">
                <g:renderErrors bean="${solicitacaoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${solicitacaoInstance?.id}" />
                <g:hiddenField name="version" value="${solicitacaoInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="data"><g:message code="solicitacao.data.label" default="Data" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: solicitacaoInstance, field: 'data', 'errors')}">
                                    <g:datePicker name="data" precision="day" value="${solicitacaoInstance?.data}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="descricao"><g:message code="solicitacao.descricao.label" default="Descricao" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: solicitacaoInstance, field: 'descricao', 'errors')}">
                                    <g:textField name="descricao" value="${solicitacaoInstance?.descricao}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="requerente"><g:message code="solicitacao.requerente.label" default="Requerente" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: solicitacaoInstance, field: 'requerente', 'errors')}">
                                    <g:select name="requerente.id" from="${protocolo1_1.Pessoa.list()}" optionKey="id" value="${solicitacaoInstance?.requerente?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="situacoes"><g:message code="solicitacao.situacoes.label" default="Situacoes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: solicitacaoInstance, field: 'situacoes', 'errors')}">
                                    
<ul>
<g:each in="${solicitacaoInstance?.situacoes?}" var="s">
    <li><g:link controller="situacao" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="situacao" action="create" params="['solicitacao.id': solicitacaoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'situacao.label', default: 'Situacao')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tipo"><g:message code="solicitacao.tipo.label" default="Tipo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: solicitacaoInstance, field: 'tipo', 'errors')}">
                                    <g:select name="tipo.id" from="${protocolo1_1.Tipo.list()}" optionKey="id" value="${solicitacaoInstance?.tipo?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
