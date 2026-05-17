<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-xl mx-auto px-4 py-10 fade-in">

    <h2 class="text-2xl font-bold mb-6" style="color: var(--text-primary);">
        <c:choose>
            <c:when test="${not empty reservation}">✏️ Edit Reservation</c:when>
            <c:otherwise>📅 Make a Reservation</c:otherwise>
        </c:choose>
    </h2>

    <c:if test="${not empty errorMessage}">
        <div class="glass px-4 py-3 rounded-xl mb-4 text-sm" style="border-left: 3px solid #dc2626; color: #dc2626;">
            ❌ ${errorMessage}
        </div>
    </c:if>

    <div class="glass rounded-2xl p-6">

        <!-- CREATE FORM -->
        <c:if test="${empty reservation}">
            <form action="/reservations/create" method="post" class="space-y-5">

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Select Table</label>
                    <select name="tableId" required class="w-full input-dark rounded-xl px-4 py-3 text-sm">
                        <option value="">-- Choose a table --</option>
                        <c:forEach var="t" items="${tables}">
                            <option value="${t.tableId}" ${t.tableId == preSelectedTableId ? 'selected' : ''}>
                                Table ${t.tableNumber} — ${t.capacity} pax — ${t.location}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Date</label>
                    <input type="date" name="reservationDate" required min="${today}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Time</label>
                    <input type="time" name="reservationTime" required
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Number of Guests</label>
                    <input type="number" name="guestCount" required min="1" value="${preSelectedGuests}"
                           placeholder="e.g. 3" class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <button type="submit" class="w-full btn-gradient text-white font-semibold py-3 rounded-xl text-sm">
                    Confirm Reservation
                </button>
            </form>
        </c:if>

        <!-- EDIT FORM -->
        <c:if test="${not empty reservation}">
            <form action="/reservations/update/${reservation.reservationId}" method="post" class="space-y-5">

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Table</label>
                    <div class="w-full input-dark rounded-xl px-4 py-3 text-sm" style="color: var(--text-secondary);">
                        Table ${reservation.table.tableNumber} —
                        ${reservation.table.capacity} pax — ${reservation.table.location}
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Date</label>
                    <input type="date" name="reservationDate" required value="${reservation.reservationDate}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Time</label>
                    <input type="time" name="reservationTime" required value="${reservation.reservationTime}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium mb-1.5" style="color: var(--text-primary);">Number of Guests</label>
                    <input type="number" name="guestCount" required min="1" value="${reservation.guestCount}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <button type="submit"
                        class="w-full font-semibold py-3 rounded-xl transition text-sm"
                        style="background: rgba(37,99,235,0.06); color: #2563eb; border: 1px solid rgba(37,99,235,0.15);">
                    Save Changes
                </button>
                <a href="/reservations/my" class="block text-center text-sm mt-1 transition" style="color: var(--text-muted);">
                    Cancel
                </a>
            </form>
        </c:if>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>