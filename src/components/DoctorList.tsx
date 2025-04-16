import { useState } from 'react';

function DoctorList() {
  const [selectedSpecialty, setSelectedSpecialty] = useState('all');
  const [doctors, setDoctors] = useState([
    {
      id: 1,
      name: "Dr. John Smith",
      specialty: "Cardiologist",
      experience: "15 years",
      rating: 4.8,
      image: "/doctors/doctor1.jpg" 
    },
    // ... existing doctor data ...
  ]);
  const [searchQuery, setSearchQuery] = useState('');

  const specialties = [
    'all',
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Neurologist',
    'Orthopedic'
  ];

  const filteredDoctors = doctors
    .filter(doctor => selectedSpecialty === 'all' || doctor.specialty === selectedSpecialty)
    .filter(doctor => 
      doctor.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      doctor.specialty.toLowerCase().includes(searchQuery.toLowerCase())
    );

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-6 flex flex-col md:flex-row gap-4">
        {/* Add search input */}
        <input
          type="text"
          placeholder="Search doctors by name or specialty..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="p-2 border rounded-md flex-grow"
        />
        
        {/* Existing specialty filter */}
        <select 
          value={selectedSpecialty}
          onChange={(e) => setSelectedSpecialty(e.target.value)}
          className="p-2 border rounded-md"
        >
          {specialties.map(specialty => (
            <option key={specialty} value={specialty}>
              {specialty === 'all' ? 'All Specialties' : specialty}
            </option>
          ))}
        </select>
      </div>

      {/* Existing doctor list grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredDoctors.map((doctor) => (
          // ... existing doctor card code ...
        ))}
      </div>
    </div>
  );
}

export default DoctorList; 
