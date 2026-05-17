<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-10 fade-in">
    <div class="mb-8">
        <h2 class="text-2xl font-bold mb-2" style="color:var(--text-primary);">📋 Admin: Special Requests</h2>
        <p style="color:var(--text-secondary);">Review and manage special requests from customers.</p>
    </div>

    <div class="glass rounded-2xl overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left table-dark text-sm" id="adminRequestsTable">
                <thead>
                    <tr class="font-medium" style="color:var(--text-primary);border-bottom:1px solid var(--border-light);">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">Customer ID</th>
                        <th class="px-6 py-4">Reservation ID</th>
                        <th class="px-6 py-4">Request</th>
                        <th class="px-6 py-4">Submitted</th>
                        <th class="px-6 py-4">Status</th>
                        <th class="px-6 py-4 text-right">Actions</th>
                    </tr>
                </thead>
                <tbody id="requestsBody"></tbody>
            </table>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", loadAllRequests);

    async function loadAllRequests() {
        try {
            const response = await fetch('/api/SpecialRequest');
            const data = await response.json();
            const tbody = document.getElementById('requestsBody');
            tbody.innerHTML = '';
            if (data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="7" class="px-6 py-8 text-center" style="color:var(--text-muted);">No special requests found.</td></tr>';
                return;
            }
            data.forEach(req => {
                const dateObj = new Date(req.submitted);
                const dateStr = dateObj.toLocaleDateString() + ' ' + dateObj.toLocaleTimeString();
                let statusHtml = '';
                let actionHtml = '';
                if (req.status === 'ACCEPTED') {
                    statusHtml = '<span style="background:rgba(22,163,74,0.08);color:#16a34a;border:1px solid rgba(22,163,74,0.15);" class="px-2 py-1 rounded-full text-xs">Accepted</span>';
                    actionHtml = '<span class="text-xs" style="color:var(--text-muted);">No Action Needed</span>';
                } else if (req.status === 'REJECTED') {
                    statusHtml = '<span style="background:rgba(220,38,38,0.06);color:#dc2626;border:1px solid rgba(220,38,38,0.12);" class="px-2 py-1 rounded-full text-xs">Rejected</span>';
                    actionHtml = '<span class="text-xs" style="color:var(--text-muted);">No Action Needed</span>';
                } else {
                    statusHtml = '<span style="background:rgba(202,138,4,0.08);color:#ca8a04;border:1px solid rgba(202,138,4,0.12);" class="px-2 py-1 rounded-full text-xs">Pending</span>';
                    actionHtml = `
                        <button onclick="acceptRequest(\${req.id})" class="text-xs px-3 py-1.5 rounded-lg transition mr-1" style="background:rgba(22,163,74,0.06);color:#16a34a;border:1px solid rgba(22,163,74,0.15);">Accept</button>
                        <button onclick="rejectRequest(\${req.id})" class="text-xs px-3 py-1.5 rounded-lg transition" style="background:rgba(220,38,38,0.05);color:#dc2626;border:1px solid rgba(220,38,38,0.12);">Reject</button>
                    `;
                }
                tbody.innerHTML += `
                    <tr style="border-top:1px solid var(--border-light);">
                        <td class="px-6 py-4 font-medium" style="color:var(--text-primary);">#\${req.id}</td>
                        <td class="px-6 py-4" style="color:var(--text-secondary);">\${req.customerID}</td>
                        <td class="px-6 py-4" style="color:var(--text-secondary);">\${req.reservationId}</td>
                        <td class="px-6 py-4 max-w-xs truncate" style="color:var(--text-primary);" title="\${req.response}">\${req.response}</td>
                        <td class="px-6 py-4" style="color:var(--text-secondary);">\${dateStr}</td>
                        <td class="px-6 py-4">\${statusHtml}</td>
                        <td class="px-6 py-4 text-right whitespace-nowrap">\${actionHtml}</td>
                    </tr>
                `;
            });
        } catch (error) { console.error('Error fetching requests:', error); }
    }

    async function acceptRequest(id) {
        try {
            const r = await fetch('/api/SpecialRequest/' + id + '/accept', { method: 'PATCH' });
            if (r.ok) { showToast('Request accepted.', 'success'); loadAllRequests(); }
            else { showToast('Failed to accept request.', 'error'); }
        } catch (e) { console.error(e); }
    }

    async function rejectRequest(id) {
        try {
            const r = await fetch('/api/SpecialRequest/' + id + '/reject', { method: 'PATCH' });
            if (r.ok) { showToast('Request rejected.', 'info'); loadAllRequests(); }
            else { showToast('Failed to reject request.', 'error'); }
        } catch (e) { console.error(e); }
    }
</script>

<%@ include file="../common/footer.jsp" %>
