<html>
    <head>
        <title>Sistema De Protocolo Facisa</title>
        <meta name="layout" content="main" />
        <style type="text/css" media="screen">
      
        
        #nav {
            margin-top:20px;
            margin-left:30px;
            width:228px;
            float:left;

        }
        .homePagePanel * {
            margin:0px;
        }
        .homePagePanel .panelBody ul {
            list-style-type:none;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody h1 {
            text-transform:uppercase;
            font-size:1.1em;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody {
            background: url(images/leftnav_midstretch.png) repeat-y top;
            margin:0px;
            padding:15px;
        }
        .homePagePanel .panelBtm {
            background: url(images/leftnav_btm.png) no-repeat top;
            height:20px;
            margin:0px;
        }

        .homePagePanel .panelTop {
            background: url(images/leftnav_top.png) no-repeat top;
            height:11px;
            margin:0px;
        }
        h2 {
            margin-top:15px;
            margin-bottom:15px;
            font-size:1.2em;
        }
        #pageBody {
            margin-left:280px;
            margin-right:20px;
        }
        </style>
    </head>
    <body>
        <g:form controller="solicitacao" action="create">
        	<div class="buttons">
	        	<span class="button"><g:submitButton name="create" class="save" value="Criar Solicitacao" /></span>
	        </div>
		</g:form>
        <div class="list">
            <table>
                <thead>
                    <tr>
                        <g:sortableColumn property="data" title="${message(code: 'solicitacao.data.label', default: 'Data')}" />
                    
                        <g:sortableColumn property="descricao" title="${message(code: 'solicitacao.descricao.label', default: 'Descricao')}" />
                    
                        <th><g:message code="solicitacao.requerente.label" default="Requerente" /></th>
                    
                        <th><g:message code="solicitacao.tipo.label" default="Tipo" /></th>
                    </tr>
                </thead>
                <tbody>
                <g:each in="${solicitacoes}" status="i" var="solicitacaoInstance">
                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    
                        <td><g:link action="show" id="${solicitacaoInstance.id}"><g:formatDate date="${solicitacaoInstance.data}" /></g:link></td>
                    
                        <td><g:link action="show" id="${solicitacaoInstance.id}">${fieldValue(bean: solicitacaoInstance, field: "descricao")}</g:link></td>
                    
                        <td><g:link action="show" id="${solicitacaoInstance.id}">${fieldValue(bean: solicitacaoInstance, field: "requerente")}</g:link></td>
                    
                        <td><g:link action="show" id="${solicitacaoInstance.id}">${fieldValue(bean: solicitacaoInstance, field: "tipo")}</g:link></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
        <div class="paginateButtons">
            <g:paginate total="${solicitacaoInstanceTotal}" />
        </div>
    </body>
</html>
