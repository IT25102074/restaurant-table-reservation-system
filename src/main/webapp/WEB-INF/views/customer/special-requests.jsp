<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">
    <div class="mb-8">
        <h2 class="text-2xl font-bold mb-2" style="color:var(--text-primary);">✨ Special Requests</h2>
        <p style="color:var(--text-secondary);">Add special instructions or requests for your upcoming reservations.</p>
    </div>

    <div class="glass rounded-2xl p-6 mb-10 card-hover">
        <h3 class="text-lg font-semibold mb-4" style="color:var(--text-primary);">Make a Request</h3>
        <form id="specialRequestForm" class="space-y-4" onsubmit="submitRequest(event)">
            <input type="hidden" id="customerName" value="${sessionScope.userName}" />
            <input type="hidden" id="customerId" value="${sessionScope.loggedInUser.userId}" />
            <div>
                <label class="block text-sm font-medium mb-1.5" style="color:var(--text-secondary);">Select Reservation</label>
                <select id="reservationId" required class="w-full input-dark rounded-xl px-4 py-3">
                <option value="" disabled selected>-- Choose an upcoming reservation --</option>
                <c:forEach var="res" items="${reservations}">
                    <c:if test="${res.status == 'PENDING' || res.status == 'CONFIRMED'}">
                        <option value="${res.reservationId}">
                            Table ${res.table.tableNumber} — ${res.reservationDate} at ${res.reservationTime} (${res.status})
                        </option>
                    </c:if>
                </c:forEach>
            </select>
            </div>
            <div>
                <label class="block text-sm font-medium mb-1.5" style="color:var(--text-secondary);">Your Request</label>
                <textarea id="requestText" required rows="3" placeholder="e.g., We are celebrating a birthday, can we get a corner table?" class="w-full input-dark rounded-xl px-4 py-3"></textarea>
            </div>
            <button type="submit" class="btn-gradient text-white text-sm font-semibold px-6 py-2.5 rounded-xl w-full sm:w-auto">Submit Request</button>
        </form>
    </div>

    <h3 class="text-xl font-bold mb-4" style="color:var(--text-primary);">Your Past Requests</h3>
    <div id="requestsList" class="space-y-4"></div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => { loadRequests(); });

    async function loadRequests() {
        const customerId = document.getElementById("customerId").value;
        if (!customerId) return;
        try {
            const response = await fetch('/api/SpecialRequest/Customer/' + customerId);
            const data = await response.json();
            const container = document.getElementById('requestsList');
            container.innerHTML = '';
            if (data.length === 0) {
                container.innerHTML = '<div class="glass rounded-2xl text-center py-12" style="color:var(--text-muted);"><p>You haven\'t made any special requests yet.</p></div>';
                return;
            }
            data.forEach(req => {
                const dateObj = new Date(req.submitted);
                const dateStr = dateObj.toLocaleDateString() + ' ' + dateObj.toLocaleTimeString();
                let statusBadge = '';
                if (req.status === 'ACCEPTED') {
                    statusBadge = '<span style="background:rgba(22,163,74,0.08);color:#16a34a;border:1px solid rgba(22,163,74,0.15);" class="px-2 py-1 rounded-full text-xs">Accepted</span>';
                } else if (req.status === 'REJECTED') {
                    statusBadge = '<span style="background:rgba(220,38,38,0.06);color:#dc2626;border:1px solid rgba(220,38,38,0.12);" class="px-2 py-1 rounded-full text-xs">Rejected</span>';
                } else {
                    statusBadge = '<span style="background:rgba(202,138,4,0.08);color:#ca8a04;border:1px solid rgba(202,138,4,0.12);" class="px-2 py-1 rounded-full text-xs">Pending</span>';
                }
                container.innerHTML += `
                    <div class="glass rounded-2xl p-6 card-hover" id="req-card-\${req.id}">
                        <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
                            <div>
                                <h4 class="font-bold mb-2" style="color:var(--text-primary);">Request #\${req.id} (Reservation #\${req.reservationId}) \${statusBadge}</h4>
                                <div class="p-3 rounded-lg text-sm" style="background:rgba(139,94,60,0.03);border:1px solid var(--border-light);color:var(--text-primary);">
                                    <span style="font-size:0.7rem;font-weight:700;text-transform:uppercase;letter-spacing:0.08em;color:#9a8d82;">Your Request</span><br/>
                                    "\${req.response != null ? req.response : '(no text saved)'}"
                                </div>
                                <p class="text-xs mt-2" style="color:var(--text-muted);">Submitted: \${dateStr}</p>
                            </div>
                            <div class="flex gap-2 flex-shrink-0 mt-3 sm:mt-0">
                                <button onclick="deleteRequest(\${req.id})" class="text-sm px-4 py-2 rounded-xl transition font-medium" style="background:rgba(220,38,38,0.05);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Delete</button>
                            </div>
                        </div>
                    </div>`;
            });
        } catch (error) { console.error('Error loading requests:', error); }
    }

    async function submitRequest(event) {
        event.preventDefault();
        const payload = {
            reservationId: parseInt(document.getElementById('reservationId').value),
            CustomerName: document.getElementById('customerName').value,
            Request: document.getElementById('requestText').value
        };
        try {
            const response = await fetch('/api/SpecialRequest', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                credentials: 'same-origin',
                body: JSON.stringify(payload)
            });
            if (response.ok) {
                document.getElementById('requestText').value = '';
                loadRequests();
                const btn = document.querySelector('#specialRequestForm button[type=submit]');
                btn.textContent = '✅ Submitted!';
                setTimeout(() => btn.textContent = 'Submit Request', 2500);
            } else {
                alert("Failed to submit request. Please try again.");
            }
        } catch (error) { console.error("Error:", error); alert("Error submitting request."); }
    }

    async function deleteRequest(id) {
        try {
            const response = await fetch('/api/SpecialRequest/' + id, { method: 'DELETE' });
            if (response.ok) { showToast('Request deleted.', 'success'); loadRequests(); }
            else { showToast('Failed to delete request.', 'error'); }
        } catch (error) { console.error('Error:', error); showToast('Error deleting request.', 'error'); }
    }
</script>

<%@ include file="../common/footer.jsp" %>
