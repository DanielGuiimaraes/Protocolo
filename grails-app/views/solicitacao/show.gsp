
<%@ page import="protocolo1_1.Solicitacao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'solicitacao.label', default: 'Solicitacao')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <gui:resources components="dialog, richEditor"/>
    </head>
    <body>
        <div class="body">
        	<h1 id="mensagem" style="color:red"></h1>
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="solicitacao.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: solicitacaoInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="solicitacao.data.label" default="Data" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${solicitacaoInstance?.data}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="solicitacao.descricao.label" default="Descricao" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: solicitacaoInstance, field: "descricao")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="solicitacao.requerente.label" default="Requerente" /></td>
                            
                            <td valign="top" class="value"><g:link controller="pessoa" action="show" id="${solicitacaoInstance?.requerente?.id}">${solicitacaoInstance?.requerente?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="solicitacao.situacoes.label" default="Situacoes" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${solicitacaoInstance.situacoes}" var="s">
                                    <li><g:link controller="situacao" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="solicitacao.tipo.label" default="Tipo" /></td>
                            
                            <td valign="top" class="value"><g:link controller="tipo" action="show" id="${solicitacaoInstance?.tipo?.id}">${solicitacaoInstance?.tipo?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
            	<g:if test="${podeResolver && podeRejeitar}">
                 <gui:dialog title="Resolver Solicitação"
                  			 draggable="false"
                   			 modal="true"
                   			 form="true"
                   			 controller="solicitacao"
                   			 action="resolver"
                   			 update="mensagem"
                   			 triggers="[show:[type:'button', text:'Resolver', on: 'click']]">
                  		<label for="id_justificativa">Justificativa:</label>
                   		<g:textArea name="justificativa"/>
                   		<g:hiddenField name="id" value="${solicitacaoInstance.id}"/>
              	</gui:dialog>
              
                 <gui:dialog title="Rejeitar Solicitação"
                  			 draggable="false"
                   			 modal="true"
                   			 form="true"
                   			 controller="solicitacao"
                   			 action="rejeitar"
                   			 update="mensagem"
                   			 triggers="[show:[type:'button', text:'Rejeitar', on: 'click']]">
                  		<label for="id_justificativa">Justificativa:</label>
                   		<g:textArea name="justificativa"/>
                   		<g:hiddenField name="id" value="${solicitacaoInstance.id}"/>
              	</gui:dialog>
              	
              	
                 <gui:dialog title="Encaminhar Solicitação"
                  			 draggable="false"
                   			 modal="true"
                   			 form="true"
                   			 controller="solicitacao"
                   			 action="encaminhar"
                   			 update="mensagem"
                   			 triggers="[show:[type:'button', text:'Encaminhar', on: 'click']]">
                   		<label for="id_remetente">Para:</label>
                   		<g:select name="remetente" from="${protocolo1_1.Pessoa.list()}" optionKey="id"/>
                   		<br/>	
                  		<label for="id_justificativa">Justificativa:</label>
                   		<g:textArea name="justificativa"/>
                   		<g:hiddenField name="id" value="${solicitacaoInstance.id}"/>
              	</gui:dialog>
              	</g:if>
            </div>
        </div>
    </body>
</html>
