<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="do" uri="/WEB-INF/tags/sortTag.tld" %>

<c:if test="${hasReferenceEntity}">
    <c:if test="${not empty databaseObject.referenceEntity}">
        <div class="clearfix">
            <fieldset class="fieldset-details">
                <legend>External Reference Information</legend>

                <div class="fieldset-pair-container">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">External Reference</div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <a href="${databaseObject.referenceEntity.url}" class="" title="Go to External Reference">${databaseObject.referenceEntity.displayName}</a>
                    </div>

                    <c:if test="${isReferenceSequence}">
                        <c:if test="${not empty databaseObject.referenceEntity.geneName}">
                            <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Gene Names</div>
                            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                <div>
                                <c:forEach var="geneName" items="${databaseObject.referenceEntity.geneName}" varStatus="loop">
                                    ${geneName}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </c:if>

                    <c:if test="${databaseObject.referenceType == 'ReferenceGeneProduct'}">
                        <c:if test="${not empty databaseObject.referenceEntity.chain}">
                            <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Chain</div>
                            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                <div>
                                <c:forEach var="chain" items="${databaseObject.referenceEntity.chain}" varStatus="loop">
                                    ${chain}<c:if test="${!loop.last}">, </c:if>
                                </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty databaseObject.referenceEntity.referenceGene}">
                            <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Reference Genes</div>
                            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                <div class="wrap">
                                    <c:forEach var="referenceGene" items="${do:sortByDisplayName(databaseObject.referenceEntity.referenceGene)}" varStatus="loop">
                                        <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                                            <a href="${referenceGene.url}" title="show ${referenceGene.displayName}" rel="nofollow">${referenceGene.displayName}</a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty databaseObject.referenceEntity.referenceTranscript}">
                            <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Reference Transcript</div>
                            <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                                <div>
                                    <ul class="list">
                                        <c:forEach var="referenceTranscript" items="${databaseObject.referenceEntity.referenceTranscript}">
                                            <li><a href="${referenceTranscript.url}" title="show ${referenceTranscript.displayName}" rel="nofollow">${referenceTranscript.displayName}</a></li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
                    </c:if>

                    <c:if test="${not empty databaseObject.referenceEntity.otherIdentifier}">
                        <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Other Identifiers</div>
                        <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                            <div class="wrap">
                                <c:forEach var="otherIdentifier" items="${databaseObject.referenceEntity.otherIdentifier}">
                                    <div class="favth-col-lg-3 favth-col-md-3 favth-col-sm-9 favth-col-xs-12 text-overflow">
                                        ${otherIdentifier}
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </fieldset>
        </div>
    </c:if>
</c:if>

<c:if test="${ databaseObject.schemaClass == 'Complex' &&  not empty databaseObject.hasComponent || databaseObject.schemaClass == 'Polymer' && not empty databaseObject.repeatedUnit || isEntitySet && not empty databaseObject.hasMember || databaseObject.schemaClass == 'CandidateSet' && not empty databaseObject.hasCandidate }">
    <fieldset class="fieldset-details">
        <legend>Participants</legend>
        <c:if test="${databaseObject.schemaClass == 'Complex'}">
            <c:if test="${not empty databaseObject.hasComponent}">
                <div class="fieldset-pair-container">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">components</div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="hasComponent" items="${databaseObject.fetchHasComponent()}">
                                    <li>
                                        <i class="sprite sprite-resize sprite-${hasComponent.object.schemaClass} sprite-position" title="${hasComponent.object.schemaClass}"></i>
                                        <c:if test="${hasComponent.stoichiometry gt 1}">${hasComponent.stoichiometry} x </c:if>
                                        <a href="../detail/${hasComponent.object.stId}" class="" title="Show Details" rel="nofollow">${hasComponent.object.displayName} <c:if test="${not empty hasComponent.object.speciesName}">(${hasComponent.object.speciesName})</c:if></a></li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${databaseObject.schemaClass == 'Polymer'}">
            <c:if test="${not empty databaseObject.repeatedUnit}">
                <div class="fieldset-pair-container">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">repeated unit</div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <li>
                                    <i class="sprite sprite-resize sprite-${databaseObject.fetchRepeatedUnit().object.schemaClass} sprite-position" title="${databaseObject.fetchRepeatedUnit().object.schemaClass}"></i>
                                    <c:if test="${databaseObject.fetchRepeatedUnit().stoichiometry gt 1}">${databaseObject.fetchRepeatedUnit().stoichiometry} x </c:if>
                                    <a href="../detail/${databaseObject.fetchRepeatedUnit().object.stId}" class="" title="Show Details" rel="nofollow">${databaseObject.fetchRepeatedUnit().object.displayName} <c:if test="${not empty databaseObject.fetchRepeatedUnit().object.speciesName}">(${databaseObject.fetchRepeatedUnit().object.speciesName})</c:if></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${isEntitySet}">
            <c:if test="${not empty databaseObject.hasMember}">
                <div class="fieldset-pair-container">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">members</div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="hasMember" items="${databaseObject.hasMember}">
                                    <li>
                                        <i class="sprite sprite-resize sprite-${hasMember.schemaClass} sprite-position" title="${hasMember.schemaClass}"></i>
                                        <a href="../detail/${hasMember.stId}" class="" title="Show Details" rel="nofollow">${hasMember.displayName} <c:if test="${not empty hasMember.speciesName}">(${hasMember.speciesName})</c:if></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>

        <c:if test="${databaseObject.schemaClass == 'CandidateSet'}">
            <c:if test="${not empty databaseObject.hasCandidate}">
                <div class="fieldset-pair-container">
                    <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">candidates</div>
                    <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                        <div>
                            <ul class="list">
                                <c:forEach var="hasCandidate" items="${databaseObject.hasCandidate}">
                                    <li>
                                        <i class="sprite sprite-resize sprite-${hasCandidate.schemaClass} sprite-position" title="${hasCandidate.schemaClass}"></i>
                                        <a href="../detail/${hasCandidate.stId}" title="Show Details" rel="nofollow">${hasCandidate.displayName} <c:if test="${not empty hasCandidate.speciesName}">(${hasCandidate.speciesName})</c:if></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>
    </fieldset>
</c:if>

<%-- This entry is a component of --%>
<c:import url="componentOf.jsp"/>

<c:if test="${not empty databaseObject.negativelyRegulates || not empty databaseObject.positivelyRegulates}">
    <fieldset class="fieldset-details">
        <legend>This entity regulates</legend>
        <c:if test="${not empty databaseObject.negativelyRegulates}">
            <div class="fieldset-pair-container">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Negative Regulation</div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <div>
                        <ul class="list">
                            <c:forEach var="negativelyRegulates" items="${databaseObject.negativelyRegulates}">
                                <li>
                                    <a href="../detail/${negativelyRegulates.stId}" class="" title="Show Details" rel="nofollow">${negativelyRegulates.displayName}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty databaseObject.positivelyRegulates}">
            <div class="fieldset-pair-container">
                <div class="favth-col-lg-2 favth-col-md-2 favth-col-sm-3 favth-col-xs-12 details-label">Positive Regulation</div>
                <div class="favth-col-lg-10 favth-col-md-10 favth-col-sm-9 favth-col-xs-12 details-field">
                    <div>
                        <ul class="list">
                            <c:forEach var="positivelyRegulates" items="${databaseObject.positivelyRegulates}">
                                <li>
                                    <a href="../detail/${positivelyRegulates.stId}" class="" title="Show Details" rel="nofollow">${positivelyRegulates.displayName}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
    </fieldset>
</c:if>

<c:if test="${not empty otherFormsOfThisMolecule}">
    <fieldset class="fieldset-details">
        <legend>Other forms of this molecule</legend>
        <div class="wrap overflow clearfix">
            <c:forEach var="derivedEwas" items="${otherFormsOfThisMolecule}" varStatus="loop">
                <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                    <a href="../detail/${derivedEwas.stId}" title="Open ${derivedEwas.displayName}" rel="nofollow">${derivedEwas.displayName}</a>
                </div>
            </c:forEach>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty databaseObject.inferredFrom}">
    <fieldset class="fieldset-details">
        <legend>Inferred From</legend>
        <div class="wrap">
            <ul class="overflow list">
                <c:forEach var="inferredFrom" items="${databaseObject.inferredFrom}">
                    <li><a href="../detail/${inferredFrom.stId}" class="" title="Show Details" rel="nofollow">${inferredFrom.displayName} <c:if test="${not empty inferredFrom.speciesName}"> (${inferredFrom.speciesName})</c:if></a></li>
                </c:forEach>
            </ul>
        </div>
    </fieldset>
</c:if>

<c:if test="${not empty inferredTo}">
    <fieldset class="fieldset-details">
        <legend>Inferred To</legend>
        <div class="wrap overflow clearfix">
            <c:forEach items="${inferredTo}" var="inferredToMap">
                <c:forEach items="${inferredToMap.value}" var="inferredTo">
                    <div class="favth-col-lg-6 favth-col-md-6 favth-col-sm-12 favth-col-xs-12 text-overflow">
                        <a href="../detail/${inferredTo.stId}" class="" title="Show Details" rel="nofollow">${inferredTo.displayName} <c:if test="${not empty inferredTo.speciesName}"> (${inferredTo.speciesName})</c:if></a>
                    </div>
                </c:forEach>
            </c:forEach>
        </div>
    </fieldset>
</c:if>


<c:if test="${databaseObject.schemaClass == 'EntityWithAccessionedSequence'}">
    <c:if test="${not empty databaseObject.hasModifiedResidue}">
        <fieldset class="fieldset-details">
            <legend>Modified Residues</legend>
            <div class="wrap">
                <table class="dt-fixed-header">
                    <thead>
                    <tr>
                        <th style="width:20px;">Name</th>
                        <th style="width:20px;">Coordinate</th>
                        <th style="width:20px;">Modification</th>
                        <th style="width:200px;">PsiMod</th>
                    </tr>
                    </thead>
                </table>
                <div class="dt-content-ovf">
                    <table>
                        <tbody>
                        <c:forEach var="modifiedResidue" items="${databaseObject.hasModifiedResidue}">
                            <tr>
                                <td style="vertical-align: middle; width:25px;">${modifiedResidue.displayName}</td>
                                <c:if test="${modifiedResidue.schemaClass != 'FragmentReplacedModification' && modifiedResidue.schemaClass != 'FragmentDeletionModification' && modifiedResidue.schemaClass != 'FragmentInsertionModification'}">
                                    <td style="vertical-align: middle; width:25px;">${modifiedResidue.coordinate}</td>
                                    <c:choose>
                                        <c:when test="${modifiedResidue.schemaClass == 'InterChainCrosslinkedResidue' || modifiedResidue.schemaClass == 'IntraChainCrosslinkedResidue' || modifiedResidue.schemaClass == 'GroupModifiedResidue'}">
                                            <td style="width:25px;"><c:if test="${not empty modifiedResidue.modification.displayName}"><a href="../detail/${modifiedResidue.modification.stId}" class="" title="Show Details" rel="nofollow">${modifiedResidue.modification.displayName}</a></c:if></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td style="width:25px;"></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <td style="padding: 0px; width:225px;">
                                        <table border="0" class="psiModTable">
                                            <tbody>
                                                <%-- TODO: Improve here, the question is - how ? --%>
                                            <c:choose>
                                                <c:when test="${modifiedResidue.psiMod.getClass().getSimpleName() == 'ArrayList'}">
                                                    <c:forEach var="psiMod" items="${modifiedResidue.psiMod}" varStatus="loop">
                                                        <tr>
                                                            <td <c:if test="${loop.index % 2 == 0}">class="specialborder"</c:if>>
                                                                <c:if test="${not empty psiMod.displayName}"><a href="${psiMod.url}" class="" title="Show Details" rel="nofollow">${psiMod.displayName}</a></c:if>
                                                            </td>
                                                            <td <c:if test="${loop.index % 2 == 0}">class="specialborder"</c:if>>
                                                                <c:if test="${not empty psiMod.definition}">${psiMod.definition}</c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td>
                                                            <c:if test="${not empty modifiedResidue.psiMod.displayName}"><a href="${modifiedResidue.psiMod.url}" class="" title="Show Details" rel="nofollow">${modifiedResidue.psiMod.displayName}</a></c:if>
                                                        </td>
                                                        <td>
                                                            <c:if test="${not empty modifiedResidue.psiMod.definition}">${modifiedResidue.psiMod.definition}</c:if>
                                                        </td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                            </tbody>
                                        </table>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </fieldset>
    </c:if>
</c:if>