<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="../header.jsp"/>
    <div class="favth-col-lg-12 favth-col-md-12 favth-col-sm-12 favth-col-xs-12 one">
        <c:import url="title.jsp"/>

        <c:if test="${not empty topLevelNodes}">
            <c:import url="locationsInThePWB.jsp"/>
        </c:if>

        <c:if test="${not empty databaseObject.summation}">
            <fieldset class="fieldset-details">
                <legend>Summation</legend>
                <div class="details-wrap details-summation">
                    <c:forEach var="summation" items="${databaseObject.summation}">
                        <p>${summation.text}</p>
                    </c:forEach>
                </div>
            </fieldset>
        </c:if>

        <c:if test="${not empty databaseObject.literatureReference}">
            <c:import url="literatureReferences.jsp"/>
        </c:if>

        <c:if test="${clazz == 'PhysicalEntity'}">
            <c:import url="physicalEntityDetails.jsp"/>
        </c:if>

        <c:if test="${clazz == 'Event'}">
            <c:import url="eventDetails.jsp"/>
        </c:if>

        <c:import url="generalAttributes.jsp"/>

        <c:if test="${clazz == 'Regulation'}">
            <c:import url="regulationDetails.jsp"/>
        </c:if>

        <c:if test="${not empty interactions}">
            <c:import url="interactionDetails.jsp"/>
        </c:if>
    </div>
<c:import url="../footer.jsp"/>