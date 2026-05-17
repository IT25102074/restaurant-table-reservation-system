<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="max-w-6xl mx-auto px-4 py-10 fade-in">
    <div class="mb-8">
        <h2 class="text-2xl font-bold text-slate-100 mb-2">📋 Admin: Special Requests</h2>
        <p class="text-slate-400">Review and accept special requests from customers.</p>
    </div>

    <div class="glass rounded-2xl overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left table-dark text-sm" id="adminRequestsTable">
                <thead>
                    <tr class="text-slate-300 font-medium border-b border-white/10">
                        <th class="px-6 py-4">ID</th>
                        <th class="px-6 py-4">Customer ID</th>
                        <th class="px-6 py-4">Reservation ID</th>
                        <th class="px-6 py-4">Request</th>
                        <th class="px-6 py-4">Submitted</th>
                        <th class="px-6 py-4">Status</th>
                        <th class="px-6 py-4 text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-white/5" id="requestsBody">
                    <!-- Loaded via JS -->
                </tbody>
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
                tbody.innerHTML = `<tr><td colspan="7" class="px-6 py-8 text-center text-slate-500">No special requests found.</td></tr>`;
                return;
            }

            data.forEach(req => {
                const dateObj = new Date(req.submitted);
                const dateStr = dateObj.toLocaleDateString() + ' ' + dateObj.toLocaleTimeString();
                
                let statusHtml = '';
                let actionHtml = '';
                
                if (req.status === 'ACCEPTED') {
                    statusHtml = `<span class="bg-green-500/15 text-green-400 border border-green-500/20 px-2 py-1 rounded-full text-xs">Accepted</span>`;
                    actionHtml = `<span class="text-slate-500 text-xs">No Action Needed</span>`;
                } else if (req.status === 'REJECTED') {
                    statusHtml = `<span class="bg-red-500/15 text-red-400 border border-red-500/20 px-2 py-1 rounded-full text-xs">Rejected</span>`;
                    actionHtml = `<span class="text-slate-500 text-xs">No Action Needed</span>`;
                } else {
                    statusHtml = `<span class="bg-yellow-500/15 text-yellow-400 border border-yellow-500/20 px-2 py-1 rounded-full text-xs">Pending</span>`;
                    actionHtml = `
                        <button onclick="acceptRequest(\${req.id})" class="text-xs bg-green-500/20 text-green-400 hover:bg-green-500/30 px-3 py-1.5 rounded-lg border border-green-500/30 transition mr-1">Accept</button>
                        <button onclick="rejectRequest(\${req.id})" class="text-xs bg-red-500/20 text-red-400 hover:bg-red-500/30 px-3 py-1.5 rounded-lg border border-red-500/30 transition">Reject</button>
                    `;
                }

                tbody.innerHTML += `
                    <tr class="hover:bg-white/5 transition">
                        <td class="px-6 py-4 font-medium text-slate-300">#\${req.id}</td>
                        <td class="px-6 py-4 text-slate-400">\${req.customerID}</td>
                        <td class="px-6 py-4 text-slate-400">\${req.reservationId}</td>
                        <td class="px-6 py-4 text-slate-300 max-w-xs truncate" title="\${req.response}">\${req.response}</td>
                        <td class="px-6 py-4 text-slate-400">\${dateStr}</td>
                        <td class="px-6 py-4">\${statusHtml}</td>
                        <td class="px-6 py-4 text-right whitespace-nowrap">\${actionHtml}</td>
                    </tr>
                `;
            });
        } catch (error) {
            console.error('Error fetching requests:', error);
        }
    }

    async function acceptRequest(id) {
        if (!confirm('Are you sure you want to accept this request?')) return;
        
        try {
            const response = await fetch(`/api/SpecialRequest/\${id}/accept`, {
                method: 'PATCH'
            });
            
            if (response.ok) {
                alert('Request accepted successfully!');
                loadAllRequests();
            } else {
                alert('Failed to accept request.');
            }
        } catch (error) {
            console.error('Error accepting request:', error);
        }
    }

    async function rejectRequest(id) {
        if (!confirm('Are you sure you want to reject this request?')) return;
        
        try {
            const response = await fetch(`/api/SpecialRequest/\${id}/reject`, {
                method: 'PATCH'
            });
            
            if (response.ok) {
                alert('Request rejected successfully!');
                loadAllRequests();
            } else {
                alert('Failed to reject request.');
            }
        } catch (error) {
            console.error('Error rejecting request:', error);
        }
    }
</script>

<%@ include file="../common/footer.jsp" %>
