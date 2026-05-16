<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-xl mx-auto px-4 py-10 fade-in">

    <h2 class="text-2xl font-bold text-slate-100 mb-6">
        <c:choose>
            <c:when test="${not empty reservation}">✏️ Edit Reservation</c:when>
            <c:otherwise>📅 Make a Reservation</c:otherwise>
        </c:choose>
    </h2>

    <c:if test="${not empty errorMessage}">
        <div class="glass border-red-500/30 text-red-400 px-4 py-3 rounded-xl mb-4 text-sm">
            ❌ ${errorMessage}
        </div>
    </c:if>

    <div class="glass rounded-2xl p-6">

        <!-- CREATE FORM -->
        <c:if test="${empty reservation}">
            <form action="/reservations/create" method="post" class="space-y-5">

                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Select Table</label>
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
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Date</label>
                    <input type="date" name="reservationDate" required min="${java.time.LocalDate.now()}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Time</label>
                    <input type="time" name="reservationTime" required
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Number of Guests</label>
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
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Table</label>
                    <div class="w-full input-dark rounded-xl px-4 py-3 text-sm text-slate-400">
                        Table ${reservation.table.tableNumber} —
                        ${reservation.table.capacity} pax — ${reservation.table.location}
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Date</label>
                    <input type="date" name="reservationDate" required value="${reservation.reservationDate}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Time</label>
                    <input type="time" name="reservationTime" required value="${reservation.reservationTime}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-300 mb-1.5">Number of Guests</label>
                    <input type="number" name="guestCount" required min="1" value="${reservation.guestCount}"
                           class="w-full input-dark rounded-xl px-4 py-3 text-sm"/>
                </div>

                <button type="submit"
                        class="w-full bg-blue-500/20 hover:bg-blue-500/30 text-blue-400 border border-blue-500/30
                               font-semibold py-3 rounded-xl transition text-sm">
                    Save Changes
                </button>
                <a href="/reservations/my" class="block text-center text-sm text-slate-500 hover:text-slate-300 mt-1 transition">
                    Cancel
                </a>
            </form>
        </c:if>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>