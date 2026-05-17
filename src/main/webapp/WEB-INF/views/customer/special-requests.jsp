<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-5xl mx-auto px-4 py-10 fade-in">

    <div class="mb-8">
        <h2 class="text-2xl font-bold text-slate-100 mb-2">✨ Special Requests</h2>
        <p class="text-slate-400">Add special instructions or requests for your upcoming reservations.</p>
    </div>

    <!-- Submit New Request Form -->
    <div class="glass rounded-2xl p-6 mb-10 card-hover">
        <h3 class="text-lg font-semibold text-slate-200 mb-4">Make a Request</h3>
        <form id="specialRequestForm" class="space-y-4" onsubmit="submitRequest(event)">
            
            <!-- Hidden input to simulate the customer context usually handled by auth, since the REST API doesn't check session directly -->
            <input type="hidden" id="customerName" value="${sessionScope.userName}" />
            <input type="hidden" id="customerId" value="${sessionScope.loggedInUser.userId}" />

            <div>
                <label class="block text-sm font-medium text-slate-400 mb-1.5">Select Reservation</label>
                <select id="reservationId" required class="w-full input-dark rounded-xl px-4 py-3">
                    <option value="" disabled selected>-- Choose an upcoming reservation --</option>
                    <c:forEach var="res" items="${reservations}">
                        <option value="${res.reservationId}">
                            Table ${res.table.tableNumber} - ${res.reservationDate} at ${res.reservationTime}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div>
                <label class="block text-sm font-medium text-slate-400 mb-1.5">Your Request</label>
                <textarea id="requestText" required rows="3" 
                          placeholder="e.g., We are celebrating a birthday, can we get a corner table if possible?"
                          class="w-full input-dark rounded-xl px-4 py-3"></textarea>
            </div>

            <button type="submit" class="btn-gradient text-white text-sm font-semibold px-6 py-2.5 rounded-xl w-full sm:w-auto">
                Submit Request
            </button>
        </form>
    </div>

    <!-- List of Existing Requests -->
    <h3 class="text-xl font-bold text-slate-100 mb-4">Your Past Requests</h3>
    
    <div id="requestsList" class="space-y-4">
        <!-- Requests will be loaded here via JavaScript -->
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        loadRequests();
    });

    async function loadRequests() {
        const customerId = document.getElementById("customerId").value;
        if (!customerId) return;

        try {
            const response = await fetch(`/api/SpecialRequest/Customer/` + customerId);
            const data = await response.json();
            
            const container = document.getElementById('requestsList');
            container.innerHTML = '';

            if (data.length === 0) {
                container.innerHTML = `
                    <div class="glass rounded-2xl text-center py-12 text-slate-500">
                        <p>You haven't made any special requests yet.</p>
                    </div>`;
                return;
            }

            data.forEach(req => {
                const dateObj = new Date(req.submitted);
                const dateStr = dateObj.toLocaleDateString() + ' ' + dateObj.toLocaleTimeString();
                
                let statusBadge = '';
                if (req.status === 'ACCEPTED') {
                    statusBadge = '<span class="bg-green-500/15 text-green-400 border border-green-500/20 px-2 py-1 rounded-full text-xs">Accepted</span>';
                } else if (req.status === 'REJECTED') {
                    statusBadge = '<span class="bg-red-500/15 text-red-400 border border-red-500/20 px-2 py-1 rounded-full text-xs">Rejected</span>';
                } else {
                    statusBadge = '<span class="bg-yellow-500/15 text-yellow-400 border border-yellow-500/20 px-2 py-1 rounded-full text-xs">Pending</span>';
                }
                
                container.innerHTML += `
                    <div class="glass rounded-2xl p-6 card-hover" id="req-card-\${req.id}">
                        <div class="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-4">
                            <div>
                                <h4 class="font-bold text-slate-200 mb-2">Request ID: \${req.id} (Reservation: \${req.reservationId}) \${statusBadge}</h4>
                                <div class="bg-slate-800/50 p-3 rounded-lg border border-white/5 text-slate-300 text-sm">
                                    "\${req.response}"
                                </div>
                                <p class="text-xs text-slate-500 mt-2">Submitted: \${dateStr}</p>
                            </div>
                            <div class="flex gap-2 flex-shrink-0 mt-3 sm:mt-0">
                                <button onclick="deleteRequest(\${req.id})"
                                        class="text-sm bg-red-500/15 text-red-400 px-4 py-2 rounded-xl
                                               hover:bg-red-500/25 transition font-medium border border-red-500/20">Delete</button>
                            </div>
                        </div>
                    </div>
                `;
            });

        } catch (error) {
            console.error('Error loading requests:', error);
        }
    }

    async function submitRequest(event) {
        event.preventDefault();

        const reservationId = document.getElementById('reservationId').value;
        const customerName = document.getElementById('customerName').value;
        const requestText = document.getElementById('requestText').value;

        const payload = {
            reservationId: parseInt(reservationId),
            CustomerName: customerName,
            Request: requestText
        };

        try {
            const response = await fetch('/api/SpecialRequest', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload)
            });

            if (response.ok) {
                alert("Special Request submitted successfully!");
                document.getElementById('requestText').value = '';
                loadRequests();
            } else {
                alert("Failed to submit request.");
            }
        } catch (error) {
            console.error("Error submitting request:", error);
            alert("Error submitting request.");
        }
    }

    async function deleteRequest(id) {
        if (!confirm("Are you sure you want to delete this request?")) return;

        try {
            const response = await fetch(`/api/SpecialRequest/\${id}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                alert("Request deleted successfully!");
                loadRequests();
            } else {
                alert("Failed to delete request.");
            }
        } catch (error) {
            console.error("Error deleting request:", error);
        }
    }
</script>

<%@ include file="../common/footer.jsp" %>
