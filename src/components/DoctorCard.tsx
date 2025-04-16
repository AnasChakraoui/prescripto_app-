import { useState } from 'react';
import AppointmentModal from './AppointmentModal';

function DoctorCard({ doctor }) {
  const [isModalOpen, setIsModalOpen] = useState(false);

  return (
    <div className="border rounded-lg p-4 shadow-md">
      {/* ... existing doctor card UI ... */}
       
      <button
        onClick={() => setIsModalOpen(true)}
        className="mt-4 w-full bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
      >
        Book Appointment
      </button>

      <AppointmentModal
        doctor={doctor}
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
      />
    </div>
  );
}

export default DoctorCard; 
