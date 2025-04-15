import { useState } from 'react';

interface AppointmentModalProps {
  doctor: {
    id: number;
    name: string;
    specialty: string;
  };
  isOpen: boolean;
  onClose: () => void;
}

function AppointmentModal({ doctor, isOpen, onClose }: AppointmentModalProps) {
  const [appointmentData, setAppointmentData] = useState({
    date: '',
    time: '',
    reason: '',
    patientName: '',
    patientEmail: '',
    patientPhone: ''
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Here you would typically send this data to your backend
    console.log('Appointment booked:', appointmentData);
    onClose();
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
      <div className="bg-white p-8 rounded-lg max-w-md w-full">
        <h2 className="text-2xl font-bold mb-4">Book Appointment with {doctor.name}</h2>
        <form onSubmit={handleSubmit}>
          <div className="space-y-4">
            <div>
              <label className="block mb-1">Date</label>
              <input
                type="date"
                className="w-full p-2 border rounded"
                value={appointmentData.date}
                onChange={(e) => setAppointmentData({...appointmentData, date: e.target.value})}
                required
              />
            </div>
            <div>
              <label className="block mb-1">Time</label>
              <input
                type="time"
                className="w-full p-2 border rounded"
                value={appointmentData.time}
                onChange={(e) => setAppointmentData({...appointmentData, time: e.target.value})}
                required
              />
            </div>
            <div>
              <label className="block mb-1">Reason for Visit</label>
              <textarea
                className="w-full p-2 border rounded"
                value={appointmentData.reason}
                onChange={(e) => setAppointmentData({...appointmentData, reason: e.target.value})}
                required
              />
            </div>
            <div>
              <label className="block mb-1">Your Name</label>
              <input
                type="text"
                className="w-full p-2 border rounded"
                value={appointmentData.patientName}
                onChange={(e) => setAppointmentData({...appointmentData, patientName: e.target.value})}
                required
              />
            </div>
            <div>
              <label className="block mb-1">Email</label>
              <input
                type="email"
                className="w-full p-2 border rounded"
                value={appointmentData.patientEmail}
                onChange={(e) => setAppointmentData({...appointmentData, patientEmail: e.target.value})}
                required
              />
            </div>
            <div>
              <label className="block mb-1">Phone</label>
              <input
                type="tel"
                className="w-full p-2 border rounded"
                value={appointmentData.patientPhone}
                onChange={(e) => setAppointmentData({...appointmentData, patientPhone: e.target.value})}
                required
              />
            </div>
          </div>
          <div className="mt-6 flex justify-end space-x-4">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 text-gray-600 hover:text-gray-800"
            >
              Cancel
            </button>
            <button
              type="submit"
              className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
            >
              Book Appointment
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default AppointmentModal; 